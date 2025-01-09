#!/bin/bash

# Define color variables
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Function to run Ansible playbook and check its status
run_playbook() {
    local playbook_pattern=$1
    local message=$2
    echo "${CYAN}$message${RESET}"
    
    local playbook_file=$(find playbooks -name "$playbook_pattern" | head -n 1)
    
    if [ -z "$playbook_file" ]; then
        echo "Error: No playbook found matching pattern $playbook_pattern"
        exit 1
    fi
    
    ansible-playbook "$playbook_file" -i inventory.ini
    if [ $? -ne 0 ]; then
        echo "Error: Ansible playbook $playbook_file failed. Exiting."
        exit 1
    fi
    echo "Success: $message"
    echo
}

# Function to display a bordered message
display_message() {
    local message=$1
    local border=$(printf '%*s' "${#message}" | tr ' ' '*')
    echo "$border"
    echo "$message"
    echo "$border"
}

# Main script
display_message "Make sure you have a lxd container for everything below, and 'ssh XXXX' works automatically with your ssh key before proceeding."
cat ./inventory.ini
echo

read -p "PRESS ENTER TO CONTINUE, or CTRL C to CANCEL!!!"

# echo "${CYAN}1. Ensuring all nodes are online and pingable...${RESET}"
run_playbook "01*.yaml" "@@ 1. Ensuring all nodes are online and pingable..."

# echo "${CYAN}2. Installing containerd everywhere...${RESET}"
run_playbook "02*.yaml" "@@ 2. Installing containerd everywhere..."

# echo "${CYAN}3. Setting the configs for containerd on the k8ctl's...${RESET}"
run_playbook "03*.yaml" "@@ 3. Setting the configs for containerd on the k8ctl's..."

echo "All playbooks executed successfully."
