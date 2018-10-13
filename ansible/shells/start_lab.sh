#!/usr/bin/env bash

PWD="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ANSIBLE_DIR=$SCRIPT_DIR/..

cd $ANSIBLE_DIR

ansible-playbook -i environments/lab_host start_lab.yml --ask-become-pass

cd $PWD
