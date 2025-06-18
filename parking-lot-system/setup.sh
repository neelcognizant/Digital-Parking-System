#!/bin/bash

# ==============================================================================
# setup-ui.sh - Setup Script for Smart Parking System UI
#
# This script initializes the project structure, Git repo, required tools,
# and prepares the environment for collaboration.
# ==============================================================================

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================================${NC}"
echo -e "${BLUE}         Smart Parking System - UI Setup Script          ${NC}"
echo -e "${BLUE}=========================================================${NC}"

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${YELLOW}$1 not found. Installing...${NC}"
        sudo apt update
        sudo apt install -y "$1"
    else
        echo -e "${GREEN}$1 is already installed.${NC}"
    fi
}

# Step 1: Check and install git
check_command git

# Step 2: Check and install inotify-tools
check_command inotify-tools

# Step 3: Initialize Git repo if not already
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}Git repository initialized.${NC}"
else
    echo -e "${YELLOW}Git repository already exists.${NC}"
fi

# Step 4: Create .gitignore
cat > .gitignore <<EOL
*.log
*.sh
node_modules/
.DS_Store
EOL
echo -e "${GREEN}.gitignore created.${NC}"

# Step 5: Create project folders
mkdir -p src/html src/css src/js assets/images
echo -e "${GREEN}Project folder structure created.${NC}"

# Step 6: Create placeholder files
touch src/html/index.html src/html/booking.html
touch src/css/style.css src/css/responsive.css
touch src/js/main.js src/js/validation.js src/js/booking.js

echo -e "${GREEN}Initial UI files created.${NC}"

# Step 7: Optional README
cat > README.md <<EOL
# Smart Parking System - UI

This project provides the user interface for ParkSmart using HTML, CSS, JavaScript, and monitoring scripts.

## Structure

- HTML: src/html/
- CSS: src/css/
- JS: src/js/
- Scripts: monitor-ui.sh, setup-ui.sh
EOL

echo -e "${GREEN}README.md created.${NC}"

# Final message
echo -e "${BLUE}--------------------------------------------------------${NC}"
echo -e "${GREEN}Setup complete! You can now start collaborating.🚀${NC}"
echo -e "${BLUE}=========================================================${NC}"
