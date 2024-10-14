from sphinxawesome_theme import ThemeOptions
from dataclasses import asdict
from sphinxawesome_theme.postprocess import Icons
import sys
import os
sys.path.insert(0, os.path.abspath('_ext'))
import subprocess

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

html_theme = 'sphinxawesome_theme'
html_static_path = ['_static']
html_css_files = ['custom.css']
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
    "home_page_in_toc": True
}


import yaml
from docutils import nodes
from docutils.parsers.rst import Directive

class YamlValueDirective(Directive):
    has_content = False
    required_arguments = 2  # First argument: YAML file path, Second argument: key

    def run(self):
        yaml_file = self.arguments[0]
        key = self.arguments[1]
        try:
            with open(yaml_file, 'r') as f:
                data = yaml.safe_load(f)
            value = data.get(key, '')
            paragraph_node = nodes.paragraph(text=str(value))
            return [paragraph_node]
        except Exception as e:
            error_message = f"Error reading YAML file '{yaml_file}': {e}"
            error_node = self.state_machine.reporter.error(
                error_message,
                nodes.literal_block(self.block_text, self.block_text),
                line=self.lineno)
            return [error_node]

def setup(app):
    app.add_directive('yamlvalue', YamlValueDirective)