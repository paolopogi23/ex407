#!/bin/sh

ansible servers -b -i ../inventory -m user -a "name=automation"
ansible servers -b -i ../inventory -m file -a "state=directory name=/home/automation/.ssh mode=0700 owner=automation group=automation"
ansible servers -b -i ../inventory -m shell -a "echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2TWlcaJOkk/WridMCxxQuBmFIIxXXLoBm+AMMNnK8Rbhgwvohg4dYXvuI/t0ijtfHveJeBOCf3CKIhcBBSXBzH6oj+wmZBkZeg8m7DLeAv8sweNNZigQJKjIQoBZ3EU/DuxRcHfs1VbfpjEQddNPQw5UH+9gDLOvBk0cioX9TdMODYDrs8oEmAJGn3JulHC07dCkafpR59YI8iM1lsALsMpC3tG+wwFGF2U2yC00iiXcyIt0X7TbcYVdXqmLUb+qAyuFqjvDNYSKY1wUeKxnt9wWit+26Ck30rdNQWdxPKOTg2Q0wQZF9h+NW5TLls/h8vg4qgsg+BuzHSvm/B/a9 ansible@juanpaolosantiago4c.mylabserver.com  >> /home/automation/.ssh/authorized_keys"
ansible servers -b -i ../inventory -m file -a "name=/home/automation/.ssh/authorized_keys mode=600 owner=automation group=automation"
ansible servers -b -i ../inventory -m lineinfile -a 'path=/etc/sudoers line="automation ALL=(ALL)       NOPASSWD: ALL" create=yes' 
