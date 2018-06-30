#!/bin/sh
terraform apply 
sleep 2m
ansible-playbook -u ubuntu --private-key /home/ubuntu/olrudenk.pem -i hosts play.yml
