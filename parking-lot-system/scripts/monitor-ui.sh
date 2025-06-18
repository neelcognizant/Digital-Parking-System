#!/bin/bash

# ==============================================================================
# monitor-ui.sh - Shell script to monitor UI file changes
#
# This script monitors the UI code directory for changes and performs
# actions when changes are detected.
# ==============================================================================

# ANSI color codes for better output formatting
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Display script header
echo -e "${BLUE}=========================================================${NC}"
echo -e "${BLUE}      UI File Monitor for Smart Parking System           ${NC}"
echo -e "${BLUE}=========================================================${NC}"

# Default values
MONITOR_DIR="./src"
INTERVAL=1

# Function to display script usage
show_usage() {
    echo -e "${YELLOW}Usage:${NC} $0 [options]"
    echo
    echo "Options:"
    echo "  -d, --directory DIR    Directory to monitor (default: ./src)"
    echo "  -i, --interval SEC     Checking interval in seconds (default: 1)"
    echo "  -h, --help             Display this help message and exit"
    echo
    echo "Example:"
    echo "  $0 --directory ./src --interval 2"
    exit 1
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -d|--directory)
            MONITOR_DIR="$2"
            shift
            shift
            ;;
        -i|--interval)
            INTERVAL="$2"
            shift
            shift
            ;;
        -h|--help)
            show_usage
            ;;
        *)
            echo -e "${RED}Error: Unknown option: $1${NC}"
            show_usage
            ;;
    esac
done

# Check if the directory exists
if [[ ! -d "$MONITOR_DIR" ]]; then
    echo -e "${RED}Error: Directory '$MONITOR_DIR' does not exist.${NC}"
    exit 1
fi

echo -e "${GREEN}Starting to monitor directory:${NC} $MONITOR_DIR"
echo -e "${GREEN}Checking interval:${NC} $INTERVAL seconds"
echo -e "${BLUE}--------------------------------------------------------${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop monitoring${NC}"
echo -e "${BLUE}--------------------------------------------------------${NC}"

# Store initial state
initial_state=$(find "$MONITOR_DIR" -type f -name "*.html" -o -name "*.js" -o -name "*.css" | xargs stat -c "%Y %n" 2>/dev/null)

# List of files to check for validation
JS_FILES=("src/js/validation.js" "src/js/booking.js" "src/js/main.js")
CSS_FILES=("src/css/style.css" "src/css/responsive.css")
HTML_FILES=("index.html" "booking.html" "dashboard.html")

# Counter for number of changes detected
changes_counter=0

# Function to validate HTML file using W3C validator
validate_html() {
    file="$1"
    echo -e "${YELLOW}Validating HTML:${NC} $file"
    # In a real implementation, you might use a local validator or an API call to W3C validator
    # For this demo, we'll just do a simple check for opening/closing tags
    if grep -q "<html" "$file" && grep -q "</html>" "$file"; then
        echo -e "  ${GREEN}✓ HTML structure looks good${NC}"
    else
        echo -e "  ${RED}✗ HTML might be missing opening or closing tags${NC}"
    fi
}

# Function to validate CSS file
validate_css() {
    file="$1"
    echo -e "${YELLOW}Validating CSS:${NC} $file"
    # In a real implementation, you might use stylelint or another CSS validator
    # For this demo, we'll just do a simple check for syntax
    if grep -q "[^}]*{[^{]*}" "$file"; then
        echo -e "  ${GREEN}✓ CSS structure looks good${NC}"
    else
        echo -e "  ${RED}✗ CSS might have syntax issues${NC}"
    fi
}

# Function to validate JavaScript file
validate_js() {
    file="$1"
    echo -e "${YELLOW}Validating JavaScript:${NC} $file"
    # In a real implementation, you might use ESLint or another JS validator
    # For this demo, we'll just do a simple check
    if grep -q "function" "$file" && ! grep -q "console.log" "$file"; then
        echo -e "  ${GREEN}✓ JavaScript looks good${NC}"
    else
        echo -e "  ${YELLOW}⚠ JavaScript contains console.log statements or lacks functions${NC}"
    fi
}

# Function to validate files based on their extension
validate_file() {
    file="$1"
    extension="${file##*.}"
    
    case "$extension" in
        html)
            validate_html "$file"
            ;;
        css)
            validate_css "$file"
            ;;
        js)
            validate_js "$file"
            ;;
        *)
            echo -e "${YELLOW}Skipping validation for unknown file type:${NC} $file"
            ;;
    esac
}

# Function to check which file types were changed and perform actions
check_changes() {
    local changed_files=("$@")
    local html_changed=false
    local css_changed=false
    local js_changed=false
    
    # Check what types of files were changed
    for file in "${changed_files[@]}"; do
        extension="${file##*.}"
        case "$extension" in
            html)
                html_changed=true
                validate_html "$file"
                ;;
            css)
                css_changed=true
                validate_css "$file"
                ;;
            js)
                js_changed=true
                validate_js "$file"
                ;;
        esac
    done
    
    # Perform additional actions based on file types
    if $html_changed; then
        echo -e "${BLUE}HTML files changed. Checking page structure...${NC}"
        # In a real implementation, you might run more comprehensive checks here
    fi
    
    if $css_changed; then
        echo -e "${BLUE}CSS files changed. Checking for responsive design...${NC}"
        # In a real implementation, you might run style linting or other checks
    fi
    
    if $js_changed; then
        echo -e "${BLUE}JavaScript files changed. Checking for potential issues...${NC}"
        # In a real implementation, you might run JS linting or tests
    fi
}

# Trap Ctrl+C
trap ctrl_c INT

function ctrl_c() {
    echo
    echo -e "${BLUE}--------------------------------------------------------${NC}"
    echo -e "${GREEN}Monitoring stopped. Summary:${NC}"
    echo -e "${GREEN}Total changes detected:${NC} $changes_counter"
    echo -e "${BLUE}=========================================================${NC}"
    exit 0
}

# Main loop to monitor changes
while true; do
    # Get current state
    current_state=$(find "$MONITOR_DIR" -type f -name "*.html" -o -name "*.js" -o -name "*.css" | xargs stat -c "%Y %n" 2>/dev/null)
    
    # Check if state has changed
    if [[ "$current_state" != "$initial_state" ]]; then
        changes_counter=$((changes_counter+1))
        
        echo -e "${BLUE}--------------------------------------------------------${NC}"
        echo -e "${GREEN}Change detected!${NC} ($(date +"%H:%M:%S"))"
        
        # Identify which files have changed
        changed_files=()
        while read -r line; do
            timestamp=$(echo "$line" | cut -d' ' -f1)
            filename=$(echo "$line" | cut -d' ' -f2-)
            
            # Check if this file is new or modified
            if ! grep -q "$filename" <<< "$initial_state" || \
               [[ "$timestamp" != "$(grep "$filename" <<< "$initial_state" | cut -d' ' -f1)" ]]; then
                echo -e "${GREEN}Modified:${NC} $filename"
                changed_files+=("$filename")
            fi
        done <<< "$current_state"
        
        # Check files that were in the initial state but not in current state (deleted files)
        while read -r line; do
            filename=$(echo "$line" | cut -d' ' -f2-)
            
            if ! grep -q "$filename" <<< "$current_state"; then
                echo -e "${RED}Deleted:${NC} $filename"
            fi
        done <<< "$initial_state"
        
        # Check which types of files changed and perform actions
        check_changes "${changed_files[@]}"
        
        # Update the initial state
        initial_state="$current_state"
        
        echo -e "${BLUE}--------------------------------------------------------${NC}"
    fi
    
    # Wait before checking again
    sleep "$INTERVAL"
done