import os
import subprocess


def process_markdown(content, filename):
    # Add title header
    title = os.path.splitext(os.path.basename(filename))[0].replace('_', ' ').replace('-', ' ').capitalize()

    content = f"# {title} Module\n\n{content}"
    
    # Replace "##" headers with "###" headers
    lines = content.split('\n')
    processed_lines = []
    for line in lines:
        if line.startswith('## '):
            processed_lines.append(line.replace('## ', '### '))
        else:
            processed_lines.append(line)
    
    return '\n'.join(processed_lines)



def generate_module_doc(module_path, output_file):
    try:
        result = subprocess.run(
            ['terraform-docs', 'markdown', 'table', '--config', os.path.join(module_path, '.terraform-docs.yml'), module_path],
            capture_output=True,
            text=True,
            check=True
        )
        
        # Write the output to the file
        with open(output_file, 'w') as f:
            f.write(process_markdown(result.stdout, output_file))
        
        # Write the output to the README.md in the module directory
        readme_path = os.path.join(module_path, 'README.md')
        with open(readme_path, 'w') as readme:
            readme.write(process_markdown(result.stdout, readme_path))
        
        print(f"Generated README.md for {os.path.basename(module_path)}")
        
        print(f"Generated documentation for {os.path.basename(module_path)}")
    except subprocess.CalledProcessError as e:
        print(f"Error generating documentation for {os.path.basename(module_path)}:")
        print(f"Command: {e.cmd}")
        print(f"Return code: {e.returncode}")
        print(f"Standard output:\n{e.stdout}")
        print(f"Standard error:\n{e.stderr}")

def generate_terraform_submodule_docs():
    modules_dir = os.path.join(os.path.dirname(__file__), '..', '..', '..', 'modules')
    output_dir = os.path.join(os.path.dirname(__file__), 'terraform', 'submodule')

    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Iterate through each subdirectory in the modules directory
    for module in os.listdir(modules_dir):
        module_path = os.path.join(modules_dir, module)
        
        # Check if it's a directory
        if os.path.isdir(module_path):
            # Construct the output file path
            output_file = os.path.join(output_dir, f"{module}.md")
            
            # Generate documentation for the module
            generate_module_doc(module_path, output_file)

def run():
    generate_module_doc(os.path.join(os.path.dirname(__file__), '..', '..', '..'), 
                        os.path.join(os.path.dirname(__file__), 'terraform', 'relativistic.md'))
    generate_terraform_submodule_docs()

if __name__ == "__main__":
    run()
    