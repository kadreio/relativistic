from sphinxawesome_theme import ThemeOptions
from dataclasses import asdict
from sphinxawesome_theme.postprocess import Icons
import sys
import os
sys.path.insert(0, os.path.abspath('_ext'))
import subprocess
sys.path.append(os.path.join(os.path.dirname(__file__), './'))
from generate_tf_docs import run

try:
    run()
except Exception as e:
    print(f"Couldn't build Terraform documentation: {e}")

def get_latest_git_tag():
    try:
        # Run the git command to get tags sorted by creation date
        result = subprocess.run(
            ['git', 'tag', '--sort=-creatordate'],
            capture_output=True,
            text=True,
            check=True
        )

        # Filter tags that match the pattern vx.x.x
        import re

        version_pattern = re.compile(r'^v\d+\.\d+\.\d+$')
        filtered_tags = [tag for tag in result.stdout.strip().split('\n') if version_pattern.match(tag)]
        
        # If there are no matching tags, return a message
        if not filtered_tags:
            return "No tags matching the pattern vx.x.x found in this repository."
        
        # Return the most recent matching tag
        return filtered_tags[0]
        
        # Split the output into lines and get the first (most recent) tag
        tags = result.stdout.strip().split('\n')
        
        if tags:
            return tags[0]
        else:
            return "No tags found in this repository."
    
    except subprocess.CalledProcessError as e:
        return f"An error occurred: {e}"
    except FileNotFoundError:
        return "Git is not installed or not in the system PATH."

if __name__ == "__main__":
    latest_tag = get_latest_git_tag()
    print(f"The latest tag is: {latest_tag}")

# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Relativistic'
copyright = '2024, Kadre LLC'
author = 'Dylan Watt'

release = get_latest_git_tag()
version = get_latest_git_tag()

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.extlinks',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    'myst_parser'

]

source_suffix = {
    '.rst': 'restructuredtext',
    '.txt': 'markdown',
    '.md': 'markdown',
}
master_doc = "index"

# intersphinx_mapping = {
#     'python': ('https://docs.python.org/3/', None),
#     'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
# }
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output
extlinks = {
    "gh": ("https://github.com/kai687/sphinxawesome-theme/blob/main/%s", "%s"),
    "ghdir": ("https://github.com/kai687/sphinxawesome-theme/tree/main/%s", "%s"),
    "sphinxdocs": ("https://www.sphinx-doc.org/en/master/%s", "%s"),
}

html_theme = 'sphinxawesome_theme'
html_static_path = ['_static']
html_css_files = [
    'custom.css',
]
# -- Options for EPUB output
epub_show_urls = 'footnote'

pygments_style = 'sphinx'

# theme_options = ThemeOptions(
#    # Add your theme options. For example:
#    show_breadcrumbs=True,
#    home_page_in_toc=True
# )

html_permalinks_icon = Icons.permalinks_icon
html_theme_options = {
    "show_breadcrumbs": True,
    "extra_header_link_icons": {
        "GitHub": {
            "link": "https://github.com/kadreio/relativistic",
            "icon": '<svg fill="currentColor" height="26px" style="margin-top:-2px;display:inline" viewBox="0 0 45 44" xmlns="http://www.w3.org/2000/svg"><path clip-rule="evenodd" d="M22.477.927C10.485.927.76 10.65.76 22.647c0 9.596 6.223 17.736 14.853 20.608 1.087.2 1.483-.47 1.483-1.047 0-.516-.019-1.881-.03-3.693-6.04 1.312-7.315-2.912-7.315-2.912-.988-2.51-2.412-3.178-2.412-3.178-1.972-1.346.149-1.32.149-1.32 2.18.154 3.327 2.24 3.327 2.24 1.937 3.318 5.084 2.36 6.321 1.803.197-1.403.759-2.36 1.379-2.903-4.823-.548-9.894-2.412-9.894-10.734 0-2.37.847-4.31 2.236-5.828-.224-.55-.969-2.759.214-5.748 0 0 1.822-.584 5.972 2.226 1.732-.482 3.59-.722 5.437-.732 1.845.01 3.703.25 5.437.732 4.147-2.81 5.967-2.226 5.967-2.226 1.185 2.99.44 5.198.217 5.748 1.392 1.517 2.232 3.457 2.232 5.828 0 8.344-5.078 10.18-9.916 10.717.779.67 1.474 1.996 1.474 4.021 0 2.904-.027 5.247-.027 5.96 0 .58.392 1.256 1.493 1.044C37.981 40.375 44.2 32.24 44.2 22.647c0-11.996-9.726-21.72-21.722-21.72" fill="currentColor" fill-rule="evenodd"></path></svg>'
        },
        "Terraform": {
            "link": "https://registry.terraform.io/modules/kadreio/relativistic/kubernetes/latest",
            "icon": '<svg width="26px" height="26px" viewBox="12 12 40 40g" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M38.06 26.151v11.473L48 31.891V20.406l-9.94 5.745z" fill="#4040B2"/><path d="m27.03 20.406 9.94 5.745v11.473l-9.94-5.74V20.407zM16 14v11.479l9.94 5.74v-11.48L16 14zm11.03 30.624 9.94 5.74v-11.48l-9.94-5.739v11.48z" fill="#5C4EE5"/></svg>'
        },
    },
    "page_width": "100%",
    "body_max_width": "none",
}
html_favicon = 'tealfavicon.png'