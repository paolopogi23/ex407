ansible servers -b -m user -a "name=automation"
ansible servers -b -m file -a "state=directory name=/home/automation/.ssh"
ansible servers -b -m copy -a "src=/home/ansible/.ssh/id_rsa.pub dest=/home/automation/.ssh/authorized_keys owner=automation group=automation mode=0600"
ansible servers -b -m lineinfile -a "path=/etc/sudoers line='automation ALL=(ALL)       NOPASSWD: ALL'"
