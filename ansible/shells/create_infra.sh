#!/usr/bin/env bash

PWD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ANSIBLE_DIR=$SCRIPT_DIR/..

cd $ANSIBLE_DIR

ansible-playbook -i environments/lab_host create_infra.yml --ask-become-pass
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.5" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.6" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.11" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.12" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.14" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.15" &> /dev/null
ssh-keygen -f "~/.ssh/known_hosts" -R "10.0.4.16" &> /dev/null

cd $PWD
