To build docs

Install sphinx: https://www.sphinx-doc.org/en/master/usage/installation.html#os-specific-package-manager

echo 'export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"' >> ~/.zshrc

Terraform Docs

terraform-docs markdown table . > sp/docs/source/terraform/out.md