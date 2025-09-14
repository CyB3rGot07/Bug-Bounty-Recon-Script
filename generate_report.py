import os
import sys
import json
import html

def generate_txt_report(results_dir):
    report_path = os.path.join(results_dir, "report.txt")
    with open(report_path, "w") as report_file:
        report_file.write("Bug Bounty Recon Report\n")
        report_file.write("========================\n\n")

        sections = {
            "Subdomains": "subdomains/all-subs.txt",
            "Live Subdomains": "subdomains/live.txt",
            "Open Ports (Naabu)": "port_scanning/naabu.txt",
            "URLs (Wayback & Gau)": "urls/all-urls.txt",
            "JS Links": "js_links/all_js_links.txt",
            "JS Endpoints (Linkfinder)": "js_links/linkfinder_output.txt",
            "Parameters (Paramspider)": "param_discovery/params.txt",
            "Nuclei Scan Results": "vulnerability_scan/nuclei.txt",
            "Dalfox XSS Scan Results": "vulnerability_scan/dalfox.txt",
            "Subdomain Takeover (Subzy)": "subdomain_takeover/subzy.txt",
            "Subdomain Takeover (Subjack)": "subdomain_takeover/subjack.txt",
            "Broken Link Hijacking (SocialHunter)": "broken_links/social.txt"
        }

        for title, filepath in sections.items():
            full_path = os.path.join(results_dir, filepath)
            report_file.write(f"--- {title} ---\n\n")
            if os.path.exists(full_path):
                with open(full_path, "r", errors='ignore') as f:
                    content = f.read()
                    report_file.write(content)
            else:
                report_file.write("No results found.\n")
            report_file.write("\n\n")

        # Handle ffuf results separately
        report_file.write("--- Content Discovery (ffuf) ---\n\n")
        ffuf_dir = os.path.join(results_dir, "content_discovery")
        if os.path.isdir(ffuf_dir):
            ffuf_files = [f for f in os.listdir(ffuf_dir) if f.endswith('.json')]
            if ffuf_files:
                for ffuf_file in ffuf_files:
                    report_file.write(f"Results for {ffuf_file}:\n")
                    full_path = os.path.join(ffuf_dir, ffuf_file)
                    with open(full_path, "r") as f:
                        try:
                            data = json.load(f)
                            for result in data.get('results', []):
                                report_file.write(f"  - {result['url']} (Status: {result['status']}, Length: {result['length']})\n")
                        except json.JSONDecodeError:
                            report_file.write("  - Could not parse JSON file.\n")
                    report_file.write("\n")
            else:
                report_file.write("No ffuf results found.\n")
        else:
            report_file.write("No ffuf results directory found.\n")
        report_file.write("\n\n")


    print(f"TXT report generated at: {report_path}")

def generate_html_report(results_dir):
    report_path = os.path.join(results_dir, "report.html")

    # HTML and CSS for the report
    html_template = '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Bug Bounty Recon Report</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }}
            h1 {{ color: #333; }}
            .section {{ background-color: #fff; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 20px; }}
            .section-title {{ background-color: #f7f7f7; padding: 10px; border-bottom: 1px solid #ddd; cursor: pointer; font-weight: bold; }}
            .section-content {{ display: none; padding: 15px; white-space: pre-wrap; word-wrap: break-word; max-height: 400px; overflow-y: auto; }}
        </style>
        <script>
            function toggleSection(id) {{
                var content = document.getElementById(id);
                if (content.style.display === "none" || content.style.display === "") {{
                    content.style.display = "block";
                }} else {{
                    content.style.display = "none";
                }}
            }}
        </script>
    </head>
    <body>
        <h1>Bug Bounty Recon Report</h1>
        {sections_html}
    </body>
    </html>
    '''

    sections_html = ""

    sections = {
        "Subdomains": "subdomains/all-subs.txt",
        "Live Subdomains": "subdomains/live.txt",
        "Open Ports (Naabu)": "port_scanning/naabu.txt",
        "URLs (Wayback & Gau)": "urls/all-urls.txt",
        "JS Links": "js_links/all_js_links.txt",
        "JS Endpoints (Linkfinder)": "js_links/linkfinder_output.txt",
        "Parameters (Paramspider)": "param_discovery/params.txt",
        "Nuclei Scan Results": "vulnerability_scan/nuclei.txt",
        "Dalfox XSS Scan Results": "vulnerability_scan/dalfox.txt",
        "Subdomain Takeover (Subzy)": "subdomain_takeover/subzy.txt",
        "Subdomain Takeover (Subjack)": "subdomain_takeover/subjack.txt",
        "Broken Link Hijacking (SocialHunter)": "broken_links/social.txt"
    }

    for title, filepath in sections.items():
        section_id = title.replace(" ", "_").lower()
        sections_html += f'<div class="section"><div class="section-title" onclick="toggleSection(\\'{section_id}\\')">{title}</div>'
        sections_html += f'<div id="{section_id}" class="section-content">'

        full_path = os.path.join(results_dir, filepath)
        if os.path.exists(full_path) and os.path.getsize(full_path) > 0:
            with open(full_path, "r", errors='ignore') as f:
                content = f.read()
                sections_html += html.escape(content)
        else:
            sections_html += "No results found."

        sections_html += '</div></div>'

    # Handle ffuf results separately
    section_id = "content_discovery"
    sections_html += f'<div class="section"><div class="section-title" onclick="toggleSection(\\'{section_id}\\')">Content Discovery (ffuf)</div>'
    sections_html += f'<div id="{section_id}" class="section-content">'
    ffuf_dir = os.path.join(results_dir, "content_discovery")
    if os.path.isdir(ffuf_dir):
        ffuf_files = [f for f in os.listdir(ffuf_dir) if f.endswith('.json')]
        if ffuf_files:
            for ffuf_file in ffuf_files:
                sections_html += f"<b>Results for {ffuf_file}:</b><br>"
                full_path = os.path.join(ffuf_dir, ffuf_file)
                with open(full_path, "r") as f:
                    try:
                        data = json.load(f)
                        for result in data.get('results', []):
                            sections_html += f"  - {html.escape(result['url'])} (Status: {result['status']}, Length: {result['length']})<br>"
                    except json.JSONDecodeError:
                        sections_html += "  - Could not parse JSON file.<br>"
                sections_html += "<br>"
        else:
            sections_html += "No ffuf results found."
    else:
        sections_html += "No ffuf results directory found."
    sections_html += '</div></div>'

    final_html = html_template.format(sections_html=sections_html)

    with open(report_path, "w") as report_file:
        report_file.write(final_html)

    print(f"HTML report generated at: {report_path}")

def main():
    if len(sys.argv) != 2:
        print("Usage: python generate_report.py <results_directory>")
        sys.exit(1)

    results_dir = sys.argv[1]
    if not os.path.isdir(results_dir):
        print(f"Error: Directory '{results_dir}' not found.")
        sys.exit(1)

    print(f"Generating reports for results in: {results_dir}")
    generate_txt_report(results_dir)
    generate_html_report(results_dir)

if __name__ == "__main__":
    main()
