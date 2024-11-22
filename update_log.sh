#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$PROJECT_ROOT/project_log.md"

# Function to update timestamp in log file
update_timestamp() {
    current_date=$(date '+%Y-%m-%d %H:%M:%S')
    sed -i "s/Last Updated: .*/Last Updated: $current_date/" "$LOG_FILE"
    echo -e "${GREEN}✓${NC} Updated timestamp to: $current_date"
}

# Function to display log content
display_log() {
    echo -e "${BLUE}=== Project Log Contents ===${NC}"
    cat "$LOG_FILE"
}

# Function to check project structure
check_structure() {
    echo -e "\n${BLUE}=== Checking Project Structure ===${NC}"
    
    # Define expected directories
    directories=(
        "src"
        "src/assets"
        "src/assets/images"
        "src/styles"
        "src/styles/scss"
        "src/styles/scss/utils"
        "src/styles/scss/base"
        "src/styles/scss/layout"
        "src/styles/scss/components"
    )
    
    for dir in "${directories[@]}"; do
        if [ -d "$PROJECT_ROOT/$dir" ]; then
            echo -e "${GREEN}✓${NC} $dir exists"
        else
            echo -e "⚠️  $dir is missing"
        fi
    done
}

# Main execution
case "$1" in
    "update")
        update_timestamp
        ;;
    "display")
        display_log
        ;;
    "check")
        check_structure
        ;;
    *)
        echo "Usage: $0 {update|display|check}"
        echo "  update  - Update the timestamp in the log file"
        echo "  display - Show the contents of the log file"
        echo "  check   - Check the project structure"
        exit 1
        ;;
esac
