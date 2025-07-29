#!/bin/bash

# Advanced VPC Network Architecture Workshop Build Script
# This script builds and optionally deploys the workshop

set -e

echo "=========================================="
echo "Advanced VPC Network Architecture Workshop"
echo "Build and Deploy Script"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Hugo is installed
check_hugo() {
    if ! command -v hugo &> /dev/null; then
        log_error "Hugo is not installed. Please install Hugo first."
        echo "Installation instructions:"
        echo "  macOS: brew install hugo"
        echo "  Ubuntu: sudo apt-get install hugo"
        echo "  Windows: choco install hugo"
        exit 1
    fi
    
    log_info "Hugo version: $(hugo version)"
}

# Clean previous builds
clean_build() {
    log_info "Cleaning previous builds..."
    if [ -d "public" ]; then
        rm -rf public
        log_info "Removed public directory"
    fi
}

# Build the workshop
build_workshop() {
    log_info "Building workshop..."
    
    # Build with Hugo
    hugo --minify --gc
    
    if [ $? -eq 0 ]; then
        log_info "Workshop built successfully!"
        log_info "Output directory: $(pwd)/public"
    else
        log_error "Build failed!"
        exit 1
    fi
}

# Validate build
validate_build() {
    log_info "Validating build..."
    
    # Check if public directory exists
    if [ ! -d "public" ]; then
        log_error "Public directory not found!"
        exit 1
    fi
    
    # Check if index.html exists
    if [ ! -f "public/index.html" ]; then
        log_error "Index.html not found!"
        exit 1
    fi
    
    # Check if all chapters exist
    chapters=("1-introduce" "2-transit-gateway" "3-hub-vpc" "4-spoke-vpcs" "5-routing-security" "6-testing-monitoring" "7-cost-optimization" "8-cleanup")
    
    for chapter in "${chapters[@]}"; do
        if [ ! -d "public/$chapter" ]; then
            log_warn "Chapter directory not found: $chapter"
        else
            log_info "✓ Chapter found: $chapter"
        fi
    done
    
    log_info "Build validation completed"
}

# Serve locally
serve_local() {
    log_info "Starting local server..."
    log_info "Workshop will be available at: http://localhost:1313"
    log_info "Press Ctrl+C to stop the server"
    
    hugo server --bind 0.0.0.0 --port 1313 --disableFastRender
}

# Deploy to S3 (optional)
deploy_s3() {
    read -p "Enter S3 bucket name for deployment: " bucket_name
    
    if [ -z "$bucket_name" ]; then
        log_error "Bucket name cannot be empty"
        return 1
    fi
    
    log_info "Deploying to S3 bucket: $bucket_name"
    
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI is not installed"
        return 1
    fi
    
    # Sync to S3
    aws s3 sync public/ s3://$bucket_name --delete --acl public-read
    
    if [ $? -eq 0 ]; then
        log_info "Deployment successful!"
        log_info "Workshop URL: http://$bucket_name.s3-website-ap-southeast-1.amazonaws.com"
    else
        log_error "Deployment failed!"
        return 1
    fi
}

# Generate workshop statistics
generate_stats() {
    log_info "Generating workshop statistics..."
    
    # Count chapters
    chapter_count=$(find content -name "_index*.md" -not -path "content/_index*" | wc -l)
    
    # Count total words
    total_words=$(find content -name "*.md" -exec wc -w {} + | tail -1 | awk '{print $1}')
    
    # Count images
    image_count=$(find static/images -type f 2>/dev/null | wc -l)
    
    # Estimate reading time (average 200 words per minute)
    reading_time=$((total_words / 200))
    
    echo ""
    echo "=========================================="
    echo "Workshop Statistics"
    echo "=========================================="
    echo "Chapters: $chapter_count"
    echo "Total words: $total_words"
    echo "Images: $image_count"
    echo "Estimated reading time: $reading_time minutes"
    echo "=========================================="
}

# Main menu
show_menu() {
    echo ""
    echo "Choose an option:"
    echo "1) Build workshop"
    echo "2) Build and serve locally"
    echo "3) Build and deploy to S3"
    echo "4) Serve existing build locally"
    echo "5) Generate statistics"
    echo "6) Clean build directory"
    echo "7) Exit"
    echo ""
}

# Main execution
main() {
    # Check prerequisites
    check_hugo
    
    # Show workshop info
    echo "Workshop: Advanced VPC Network Architecture with Transit Gateway"
    echo "Location: $(pwd)"
    echo ""
    
    # Generate stats
    generate_stats
    
    while true; do
        show_menu
        read -p "Enter your choice [1-7]: " choice
        
        case $choice in
            1)
                clean_build
                build_workshop
                validate_build
                ;;
            2)
                clean_build
                build_workshop
                validate_build
                serve_local
                ;;
            3)
                clean_build
                build_workshop
                validate_build
                deploy_s3
                ;;
            4)
                if [ -d "public" ]; then
                    serve_local
                else
                    log_error "No existing build found. Please build first."
                fi
                ;;
            5)
                generate_stats
                ;;
            6)
                clean_build
                log_info "Build directory cleaned"
                ;;
            7)
                log_info "Goodbye!"
                exit 0
                ;;
            *)
                log_error "Invalid option. Please choose 1-7."
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
    done
}

# Run main function
main "$@"
