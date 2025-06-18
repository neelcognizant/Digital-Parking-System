import os
import json

# Define the project structure
project_structure = {
    "project_name": "parking-lot-system",
    "sprint": "Sprint-1",
    "directories": [
        "src/",
        "src/css/",
        "src/js/",
        "src/images/",
        "scripts/",
        "docs/",
        "tests/"
    ],
    "files": {
        "frontend": [
            "index.html",
            "booking.html", 
            "dashboard.html",
            "src/css/style.css",
            "src/css/responsive.css",
            "src/js/main.js",
            "src/js/validation.js",
            "src/js/booking.js"
        ],
        "scripts": [
            "scripts/monitor-ui.sh",
            "scripts/setup.sh"
        ],
        "config": [
            "package.json",
            ".gitignore",
            "README.md",
            "docs/sprint-1-requirements.md"
        ]
    }
}

# Base directory
base_dir = project_structure['project_name']

# Create directories
for dir_path in project_structure['directories']:
    full_path = os.path.join(base_dir, dir_path)
    os.makedirs(full_path, exist_ok=True)

# Create files
for category, files in project_structure['files'].items():
    for file in files:
        full_path = os.path.join(base_dir, file)
        # Ensure directory exists before file creation
        os.makedirs(os.path.dirname(full_path), exist_ok=True)
        with open(full_path, 'w') as f:
            f.write("")  # Create an empty file

# Save structure as JSON
json_path = os.path.join(base_dir, 'project-structure.json')
with open(json_path, 'w') as f:
    json.dump(project_structure, f, indent=2)

print("\n✅ All directories and files created successfully under:", base_dir)
