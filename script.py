# Let's create a comprehensive project structure for the parking lot system Sprint-1
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

print("=== PARKING LOT SYSTEM - SPRINT 1 PROJECT STRUCTURE ===")
print(f"Project: {project_structure['project_name']}")
print(f"Sprint: {project_structure['sprint']}")
print("\nDirectories to create:")
for dir in project_structure['directories']:
    print(f"  📁 {dir}")

print("\nFiles to create:")
for category, files in project_structure['files'].items():
    print(f"\n{category.upper()}:")
    for file in files:
        print(f"  📄 {file}")

# Save project structure as JSON for reference
with open('project-structure.json', 'w') as f:
    json.dump(project_structure, f, indent=2)

print("\n✅ Project structure saved to project-structure.json")