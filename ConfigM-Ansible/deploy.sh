#!/bin/bash

# Ansible Deployment Script
# Quick deployment script for different environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
ENVIRONMENT=""
PLAYBOOK="site.yml"
TAGS=""
LIMIT=""
VERBOSE=""

# Function to display usage
usage() {
    echo "Usage: $0 -e <environment> [options]"
    echo ""
    echo "Required:"
    echo "  -e, --environment    Environment (dev|prod)"
    echo ""
    echo "Options:"
    echo "  -p, --playbook      Playbook to run (site.yml|webserver.yml|database.yml)"
    echo "  -t, --tags          Run only tasks with specific tags"
    echo "  -l, --limit         Limit execution to specific hosts"
    echo "  -v, --verbose       Verbose output (-v, -vv, -vvv)"
    echo "  -c, --check         Run in check mode (dry run)"
    echo "  -h, --help          Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -e dev                           # Deploy everything to dev"
    echo "  $0 -e prod -p webserver.yml         # Deploy only web servers to prod"
    echo "  $0 -e dev -t nginx                  # Deploy only nginx tasks to dev"
    echo "  $0 -e prod -l webservers -c         # Check mode for web servers in prod"
}

# Function to log messages
log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -p|--playbook)
            PLAYBOOK="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="--tags $2"
            shift 2
            ;;
        -l|--limit)
            LIMIT="--limit $2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE="-v"
            shift
            ;;
        -vv)
            VERBOSE="-vv"
            shift
            ;;
        -vvv)
            VERBOSE="-vvv"
            shift
            ;;
        -c|--check)
            CHECK="--check"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Validate required parameters
if [[ -z "$ENVIRONMENT" ]]; then
    log_error "Environment is required"
    usage
    exit 1
fi

if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "prod" ]]; then
    log_error "Environment must be 'dev' or 'prod'"
    exit 1
fi

# Check if inventory file exists
INVENTORY_FILE="inventories/${ENVIRONMENT}/hosts"
if [[ ! -f "$INVENTORY_FILE" ]]; then
    log_error "Inventory file not found: $INVENTORY_FILE"
    exit 1
fi

# Check if playbook exists
if [[ ! -f "$PLAYBOOK" ]]; then
    log_error "Playbook not found: $PLAYBOOK"
    exit 1
fi

# Pre-deployment checks
log "Starting pre-deployment checks..."

# Check Ansible installation
if ! command -v ansible-playbook &> /dev/null; then
    log_error "Ansible is not installed"
    exit 1
fi

# Check connectivity to hosts
log "Testing connectivity to hosts..."
if ! ansible all -i "$INVENTORY_FILE" -m ping $VERBOSE &> /dev/null; then
    log_warning "Some hosts may not be reachable. Continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        log "Deployment cancelled"
        exit 1
    fi
fi

# Display deployment summary
echo ""
log "=== Deployment Summary ==="
echo "Environment: $ENVIRONMENT"
echo "Playbook: $PLAYBOOK"
echo "Inventory: $INVENTORY_FILE"
[[ -n "$TAGS" ]] && echo "Tags: $TAGS"
[[ -n "$LIMIT" ]] && echo "Limit: $LIMIT"
[[ -n "$CHECK" ]] && echo "Mode: Check (Dry Run)"
echo ""

# Confirmation prompt for production
if [[ "$ENVIRONMENT" == "prod" && -z "$CHECK" ]]; then
    log_warning "You are about to deploy to PRODUCTION environment!"
    echo "Type 'yes' to continue:"
    read -r confirmation
    if [[ "$confirmation" != "yes" ]]; then
        log "Deployment cancelled"
        exit 1
    fi
fi

# Build ansible-playbook command
ANSIBLE_CMD="ansible-playbook -i $INVENTORY_FILE $PLAYBOOK"
[[ -n "$TAGS" ]] && ANSIBLE_CMD="$ANSIBLE_CMD $TAGS"
[[ -n "$LIMIT" ]] && ANSIBLE_CMD="$ANSIBLE_CMD $LIMIT"
[[ -n "$VERBOSE" ]] && ANSIBLE_CMD="$ANSIBLE_CMD $VERBOSE"
[[ -n "$CHECK" ]] && ANSIBLE_CMD="$ANSIBLE_CMD $CHECK"

# Execute deployment
log "Starting deployment..."
log "Command: $ANSIBLE_CMD"
echo ""

START_TIME=$(date +%s)

if eval "$ANSIBLE_CMD"; then
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    
    log_success "Deployment completed successfully!"
    log "Duration: ${DURATION}s"
    
    # Post-deployment verification
    if [[ -z "$CHECK" ]]; then
        log "Running post-deployment verification..."
        
        # Check web servers
        if [[ "$PLAYBOOK" == "site.yml" || "$PLAYBOOK" == "webserver.yml" ]]; then
            log "Checking Nginx status..."
            ansible webservers -i "$INVENTORY_FILE" -m service -a "name=nginx state=started" $VERBOSE
        fi
        
        # Check database servers  
        if [[ "$PLAYBOOK" == "site.yml" || "$PLAYBOOK" == "database.yml" ]]; then
            log "Checking MySQL status..."
            ansible dbservers -i "$INVENTORY_FILE" -m service -a "name=mysql state=started" $VERBOSE
        fi
        
        log_success "Post-deployment verification completed!"
    fi
    
else
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    
    log_error "Deployment failed!"
    log "Duration: ${DURATION}s"
    log "Check the error messages above for details"
    exit 1
fi
