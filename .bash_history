vi ansible.cfg
ls -lart
cat ansible.cfg 
cat in
ls -lart
vi inventory
ssh juanpaolosantiago1c.mylabserver.com
ssh-copy-id juanpaolosantiago1c.mylabserver.com
ssh-keygen
ssh-copy-id juanpaolosantiago1c.mylabserver.com
ssh-copy-id juanpaolosantiago2c.mylabserver.com
ssh-copy-id juanpaolosantiago3c.mylabserver.com
ansible all  -m ping 
ansible all -b  -m setup -a 'filter=*ip*'
ansible all -b  -m setup -a 'filter=*name*'
ansible all  -m ping x
x
vi inventory 
ssh-copy-id localhost
ansible localhost  -m ping
vi inventory 
ansible infra  -m ping
vi inventory 
ansible backend  -m ping
vi inventory 
pwd
mkdir plays
cd plays/
vi adhoc
chmod 755 adhoc
./adhoc
pwd
vi adhoc 
mv adhoc.sh
mv adhoc adhoc.sh
./adhoc.sh 
ansible-doc user
ansible-doc copy
vi adhoc.sh 
cat ../.ssh/id_rsa
cat ../.ssh/id_rsa.pub 
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2TWlcaJOkk/WridMCxxQuBmFIIxXXLoBm+AMMNnK8Rbhgwvohg4dYXvuI/t0ijtfHveJeBOCf3CKIhcBBSXBzH6oj+wmZBkZeg8m7DLeAv8sweNNZigQJKjIQoBZ3EU/DuxRcHfs1VbfpjEQddNPQw5UH+9gDLOvBk0cioX9TdMODYDrs8oEmAJGn3JulHC07dCkafpR59YI8iM1lsALsMpC3tG+wwFGF2U2yC00iiXcyIt0X7TbcYVdXqmLUb+qAyuFqjvDNYSKY1wUeKxnt9wWit+26Ck30rdNQWdxPKOTg2Q0wQZF9h+NW5TLls/h8vg4qgsg+BuzHSvm/B/a9 ansible@juanpaolosantiago4c.mylabserver.com"
vi adhoc.sh 
./adhoc.sh 
vi adhoc.sh 
./adhoc.sh 
pwd
cd ../.ssh/w
cd ../.ssh/
ls -alrt
cd ..
ls -alrt
cd plays/
vi adhoc.sh 
./adhoc.sh 
ansible servers -i ../inventory  -m setup -b --become-user=automation
ssh automation@juanpaolosantiago1c.mylabserver.com
grep cloud /etc/sudoers
sudo grep cloud /etc/sudoers
ansible servers -i ../inventory -m lineinfile "path=/etc/sudoers line=automation ALL=(ALL)       NOPASSWD: ALL"
ansible servers -i ../inventory -m lineinfile "path=/etc/sudoers line=automation ALL=(ALL)       NOPASSWD: ALL" -b
ansible servers -i ../inventory -m lineinfile "path=/etc/sudoers line="automation ALL=(ALL)       NOPASSWD: ALL""
ansible servers -i ../inventory -m lineinfile -a 'path=/etc/sudoers line=automation ALL=(ALL)       NOPASSWD: ALL'
ansible servers -i ../inventory -m lineinfile -a '"path=/etc/sudoers line=automation ALL=(ALL)       NOPASSWD: ALL create=yes"'
ansible servers -i ../inventory -m lineinfile -a '"path=/etc/sudoers line=automation ALL=(ALL)       NOPASSWD: ALL create=yes"' -b
ansible servers -i ../inventory -m lineinfile -a 'path=/etc/sudoers line="automation ALL=(ALL)       NOPASSWD: ALL" create=yes'
ansible servers -i ../inventory -m lineinfile -a 'path=/etc/sudoers line="automation ALL=(ALL)       NOPASSWD: ALL" create=yes' -b
vi adhoc.sh 
./adhoc.sh 
cat adhoc.sh 
ssh automation@juanpaolosantiago3c.mylabserver.com
pwd
vi initial_setup.yml
ansible-playbook -i ../inventory  initial_setup.yml 
vi adhoc.sh 
vi initial_setup.yml 
ansible-playbook -i ../inventory  initial_setup.yml 
cat initial_setup.yml 
vi motd.yml
vim motd.yml
cat ../inventory 
vim motd.yml
ansible-playbook -i ../inventory motd.yml 
cat /etc/motd
vim motd.yml
ansible-playbook -i ../inventory motd.yml 
cat motd.yml 
vim motd.yml
ansible-playbook -i ../inventory motd.yml 
cat motd.yml 
vi motd.yml 
cat motd.yml 
cat ../inventory 
vi motd.yml 
cat ../inventory 
vi motd.yml 
ansible-playbook -i ../inventory motd.yml 
cat motd.yml 
vi sshd.yml
ansible-playbook -i ../inventory sshd.yml 
vi sshd.yml 
ansible-playbook -i ../inventory sshd.yml 
vi sshd.yml 
ansible-playbook -i ../inventory sshd.yml 
vi sshd.yml 
cat ../ijn
cat ../inventory 
vi sshd.yml 
ansible-playbook -i ../inventory sshd.yml 
cat motd.yml 
vi sshd.yml 
cat motd.yml 
cat sshd.yml 
vi motd.yml 
ansible-playbook motd.yml 
vi motd.yml 
vi sshd.yml 
ansible-playbook -i ../inventory sshd.yml 
vii sshd.yml 
vi sshd.yml 
ansible-playbook -i ../inventory sshd.yml 
vi sshd.yml 
cat sshd.yml
ansible-playbook sshd.yml 
ansible-playbook sshd.yml -i ../inventory 
vi sshd.yml 
ansible-playbook sshd.yml -i ../inventory 
vi sshd.yml 
ansible-playbook sshd.yml -i ../inventory 
vi sshd.yml 
ansible-playbook sshd.yml -i ../inventory 
cat sshd.yml 
vi sshd2.yml
ansible-playbook sshd2.yml -i ../inventory 
vi sshd2.yml 
cat /etc/motd
vi sshd
vi sshd2.yml 
cat motd.yml 
vi sshd2.yml 
ansible-playbook sshd2.yml -i ../inventory 
vi sshd2.yml 
ansible-playbook sshd2.yml -i ../inventory 
vi sshd2.yml 
ansible-playbook sshd2.yml -i ../inventory 
cat ../inventory 
cat sshd2.yml 
ansible-playbook sshd2.yml -i ../inventory 
vim sshd2.yml 
cat motd.yml 
cat sshd2.yml 
pwd
touch secret.yml
ansible-vault  encrypt secret.yml 
cat secret.yml 
ansible-vault decrypt secret.yml 
cat secret.yml 
ansible-vault -h
ansible-vault encrypt_string devops
ansible-vault encrypt_string devops -n user_password
vi secret.yml 
ansible-vault encrypt_string devops -n database_password
vi secret.yml 
pwd
cd ..
vi ansible.cfg 
vi vault_|key
cd plays/
ls -alrt
vim vault_key
ls -alrt
cat secret.yml 
pwd
mkdir vars
cd vars/
cat > user_list.yml
vi user_list.yml 
pwd
cd ..
vi user.yml
ansible-playbook user.yml 
ansible-playbook user.yml -i ../inventory 
cat user.yml 
cat /home/ansible/plays/vars/user_list.yml
cat secret.yml 
vi user.yml 
ansible-playbook user.yml -i ../inventory 
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
cat secret.yml
vi ansible-playbook
vi user.yml 
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
vi user.yml 
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
vi user.yml 
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
vi user.yml 
ssh jp@juanpaolosantiago3c.mylabserver.com
ls -alrt
cat secret.yml
ansible-vault create secrets.yml
vi secrets.yml
rm secrets.yml 
vi secret.yml 
ansible-vault encrypt secret.yml
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
cat secret.yml 
ansible-vault decrypt secret.yml
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
vi user.yml 
cat secret.yml
ansible-vault encrypt secret.yml
ansible-playbook user.yml -i ../inventory --vault-password-file=vault_key
ls -alt
cd plays/
ls -alt
cat adhoc.sh 
cat sshd2.yml 
cat user.yml 
pwd
vi /home/ansible/plays/secret.yml
cat /home/ansible/plays/vars/user_list.yml
mkpasswd --method=SHA-512
sudo yum installm mkpasswd
sudo yum install mkpasswd
sudo -i
ls -alt
vi adhoc.sh 
vi user.yml 
vi secret.yml 
ansible-vault decrypt secret.yml 
vi secret.yml 
ansible-playbook  user.yml 
ansible-playbook  user.yml -i ../inventory 
openssl passwd -salt 'some_plain_salt' -1 'some_plain_pass'
openssl passwd -salt 'some_plain_salt' -1 'devops'
openssl passwd -salt 'some_plain_salt' -1 'devops'  dgst -sha512
openssl passwd dgst -sha512
openssl dgst -sha512  salt 'some_plain_salt' -1 'devops'
openssl dgst -sha512  -salt 'some_plain_salt' -1 'devops'
ansible all -i localhost, -m debug -a "msg={{ 'yourpasswd' | password_hash('sha512', 'mysecretsalt') }}"
ansible all -i localhost, -m debug -a "msg={{ 'devops' | password_hash('sha512', 'mysecretsalt') }}"
vi user.yml 
vi secret.yml 
ansible-playbook localhost user.yml ../inventory 
ansible-playbook  localhost user.yml -i ../inventory 
ansible-playbook  user.yml -i ../inventory 
vi user.yml 
ansible-playbook  user.yml -i ../inventory 
vi user.yml 
ansible-playbook  user.yml -i ../inventory 
vi user.yml 
vi secret.yml 
vi user.yml 
ansible-playbook  user.yml -i ../inventory 
vi secret.yml 
ansible-vault encrypt secret.yml 
vi user.yml 
ansible-playbook user.yml -i ../inventory  --ask-vault-pass=vault_key
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
ansible all -i localhost, -m debug -a "msg={{ 'yourpasswd' | password_hash('sha512', 'mysecretsalt') }}"
ansible all -i localhost, -m debug -a "msg={{ 'devops' | password_hash('sha512', 'mysecretsalt') }}"
sudo -i
ansible-vault decrypt secrets.yml
ansible-vault decrypt secret.yml
vi secret.yml 
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
cat user.yml 
ansible-vault encrypt secret.yml 
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
cat vault_key
cat user.yml 
ls -alrt
cp -p user.yml user.yml.back
vi user.yml
ansible-vault decrypt secret.yml
vi secret.yml 
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
vi secret.yml 
vi user.yml
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
vi user.yml
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
vi user.yml
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
cat secret.yml 
cat user.yml
cat /home/ansible/plays/secret.yml
ansible-vault encrypt secret.yml 
cat secret.yml 
ls -lart
ansible-playbook user.yml -i ../inventory  --vault-password-file=vault_key
cat user.yml
ls -lart
cd plays/
ls -lart
cat user.yml
cat user.yml.back
ls -lart
cat user.yml
cat secret.yml
ansible-vault edit secret.yml 
cat secret.yml
ansible-vault edit secret.yml 
ansible-vault edit secret.yml --vault-password-file=vault_key
ls -lart
cat motd.yml
cat sshd.yml
ls -lart
cat sshd2.yml
ls -lrt
more initial_setup.yml 
ls -lrt
cat sshd2.yml 
ps -ef
ls -art
ls -alrt
cat secret.yml 
ls -lart
ansible-vault decrypt secret.yml 
cat secret.yml 
ansible-vault encrypt_string devops - user_password
ansible-vault encrypt_string devops -n user_password
vi secret.yml 
ansible-playbook user.yml --vault-password-file=vault_key
ansible-playbook user.yml --vault-password-file=vault_key -i ../inventory 
ls -lat
cat secret.yml 
vi secret.yml 
ansible-vault encrypt secret.yml 
ansible-playbook user.yml --vault-password-file=vault_key -i ../inventory 
cat motd.yml 
ls -alrt
cat user.yml
cat secret.yml 
ansible all -m setup -a 'filter=!hardware'
ansible all -m setup -a 'filter=!hardware' -i ../inventory 
ansible all -m setup -a 'filter=hardware' -i ../inventory 
ansible all -m setup -a 'filter=network' -i ../inventory 
ansible all -m setup -a 'filter=*network*' -i ../inventory 
ansible all -i ../inventory -b -m setup -a 'filter=*network*'  
ansible all -i ../inventory -b -m setup -a 'filter=ansible_ipv4.address'  
ansible all -i ../inventory -b -m setup -a 'filter=*ip*'  
ansible all -i ../inventory -b -m setup -a 'filter=ansible_default_ipv4.address'  
cat motd.yml 
ansible all --limit juanpaolosantiago1c -m setup -a 'filter=ansible_local'
ansible all --limit juanpaolosantiago1c -m setup -a 'filter=ansible_local' -o ../inventory 
ansible all --limit juanpaolosantiago1c -m setup -a 'filter=ansible_local' -i ../inventory 
cat ../inventory
ansible all --limit juanpaolosantiago1c.mylabserver.com  -m setup -a 'filter=ansible_local' -i ../inventory 
ansible localhost -m setup -a "filter=ansible_date_time"
ansible localhost -m debug -a msg="{{ '%Y-%m-%d'|strftime(ansible_date_time.epoch|int - 86400) }}"
ansible localhost -m debug  msg="{{ '%Y-%m-%d'|strftime(ansible_date_time.epoch|int - 86400) }}"
ansible localhost -m debug -a  msg="{{ '%Y-%m-%d'|strftime(ansible_date_time.epoch|int - 86400) }}"
ansible localhost -m debug -a msg: "{{ '%Y-%m-%d' | strftime( ( ansible_date_time.epoch | int ) + ( 86400 * 3 ) ) }}"
ansible localhost -m debug -a msg="{{ '%Y-%m-%d' | strftime( ( ansible_date_time.epoch | int ) + ( 86400 * 3 ) ) }}"
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
date
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
chage -l testuser
sudo -i
chage -l testuser
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
ansible-playbook time.yml 
vi time.yml
date +'%d-%m-%Y' -d '+3 days'
date +'%d-%m-%Y' -d '+30 days'
vi time.yml
vi time.yml date +'%Y-%m-%d -d +30 days'
date +'%Y-%m-%d -d +30 days'
"date +'%Y-%m-%d' -d +30 days'"
date +'%Y-%m-%d' -d +30 days'
date +'%Y-%m-%d' -d '+30 days'
(date +'%Y-%m-%d' -d '+30 days')
vi time.yml date +'%Y-%m-%d -d +30 days'
ansible-playbook time.yml 
vi time.yml date +'%Y-%m-%d -d +30 days'
ansible-playbook time.yml 
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
ansible localhost -m shell -a "(date +'%Y-%m-%d' -d '+30 days')"
vi time.yml 
ansible localhost -m shell -a "(date +'%Y-%m-%d' -d '+30 days')"
ansible-playbook time.yml 
vi test.yml
ansible-playbook test.yml 
vi test.yml
ansible-playbook test.yml 
vi test.yml
date +'%Y-%m-%d' -d '+30 days'
vi test.yml 
date +'%Y-%m-%d' -d '+30 days'
ansible-playbook test.yml 
ls -alrt
cat time.yml 
vi test.yml 
ansible-playbook time.yml 
vi test.yml 
ansible-playbook time.yml 
vi test.yml 
ansible-playbook time.yml 
vi test.yml 
ansible-playbook time.yml 
cat time.yml 
ansible-playbook test.yml 
vi test.yml 
ansible-playbook test.yml 
vi test.yml 
ansible-playbook test.yml 
cat test.yml 
date +'%s -d +30 days'
date +'%s' -d '+30 days'
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
cat time.yml 
date +'%s' -d '+30 days'
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
ansible-playbook time.yml 
sudo -i
vi time.yml 
ansible-playbook time.yml 
vi time.yml 
ansible-playbook time.yml -vvv
sudo -i
ansible-playbook time.yml -vvv
sudo chage -l testuser
ansible-config  view
date '+%s' -d '+ 1 years'
date '+%b' -d '+ 1 years'
date '+%b%m' -d '+ 1 years'
date '+%b%m%d' -d '+ 1 years'
date '+%m%d%y' -d '+ 1 years'
date '+%m%d%Y' -d '+ 1 years'
vi install.sh
chmod 755 in
chmod 755 install.sh 
./install.sh 
vi install.sh 
ls -alrt
pwd
cd ..
ls -alrt
cd plays/
ls -alrt
vi install.sh 
./install.sh 
vi install.sh 
./install.sh atd
vi install.sh 
vi install.sh at
./install.sh at
vi install.sh 
./install.sh 
./install.sh at
rpm -qa --last | head
cat install.sh 
vi install.sh 
./install.sh elinks
ls -alrt
cat install.sh 
cat ../inventory 
ssh juanpaolosantiago3c.mylabserver.com
./install.sh elinks
ls -lart
pwd
mv install.sh lab1-install.sh
ls -alrt
cat ../inventory 
yum whatprovides httpd
yum install http
yum install httpd
sudo yum install httpd
ls -alrt
vi lab2-httpd-firewall.yml
ansible-playbook lab2-httpd-firewall.yml 
ansible-playbook lab2-httpd-firewall.yml -i ../inventory 
elinks http://juanpaolosantiago1c.mylabserver.com
reset
elinks http://juanpaolosantiago1c.mylabserver.com
sudo -i
cat lab2-httpd-firewall.yml 
vi lab2-httpd-firewall.yml
ansible-playbook lab2-httpd-firewall.yml -i ../inventory -t restart-fd
elinks http://juanpaolosantiago1c.mylabserver.com
vi lab2-httpd-firewall.yml
ansible-playbook lab2-httpd-firewall.yml 
ansible-playbook lab2-httpd-firewall.yml -i ../inventory 
cat lab2-httpd-firewall.yml
vi lab3-copy-archive.yml
mv lab3-copy-archive.yml  lab3-backup-logs.yml
vi lab3-backup-logs.yml
cat ../inf
cat ../inventory 
ansible-playbook lab3-backup-logs.yml -i ../inventory 
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory -vvv
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory 
vi  lab3-backup-logs.yml
ls -alrt
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory 
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory 
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory 
ls -lrt /home/ansible/plays/temp
vi  lab3-backup-logs.yml
ansible-playbook lab3-backup-logs.yml -i ../inventory 
ls -lart
cd temp/
ls -alrt
cd log/
ls -alrt
pwd
cd ..
ls -lart
cat lab3-backup-logs.yml 
ls -lrt
cat lab3-backup-logs.yml
ls -lat
vi lab4-cron.yml
vi lab4-cron.yml 
ansible-playbook lab4-cron.yml 
ansible-playbook lab4-cron.yml -i ../int
ansible-playbook lab4-cron.yml -i ../inventory 
vi lab4-cron.yml 
ansible-playbook lab4-cron.yml -i ../inventory 
cat lab4-cron.yml 
vi lab4-delete-cron.yml
ansible-playbook lab4-delete-cron.yml 
ansible-playbook lab4-delete-cron.yml -i ../inventory 
vi lab4-delete-cron.yml
ansible-playbook lab4-delete-cron.yml -i ../inventory 
ansible-playbook lab4-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
crontab -l root
crontab -l
crontab -l root
crontab -l 
vi lab4-disabled-cron.yml 
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml 
grep devbug *
grep debug *
vi lab4-disabled-cron.yml 
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml 
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml 
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-disabled-cron.yml
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
ls -alrt
vi lab4-cron.yml
ansible-playbook lab4-cron.yml -i ../inventory 
cat lab4-disabled-cron.yml
vi lab4-cron.yml
ansible-playbook lab4-cron.yml -i ../inventory 
ls -alrt
ansible-playbook lab4-disabled-cron.yml -i ../inventory 
vi lab4-delete-cron.yml
ls -alrt
df -h
ls -lart lab*
cat lab1-install.sh
vi lab5-at-install.yml
ansible-playbook lab5-at-install.yml -i ../inventory 
vi lab5-at-scheduled-task.yml
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ls -alrt
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ls -alrt
vi lab5-at-scheduled-task.yml
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
vi lab5-at-remove-task.yml
ls -lart
vi lab5-at-scheduled-task.yml
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ls -alrt
vi lab5-at-scheduled-task.yml
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
cat lab5-at-remove-task.yml
vi lab5-at-scheduled-task.yml
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ls -alrt

vi lab5-at-remove-task.yml
cat  
vi lab5-at-scheduled-task.yml
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ls -alrt
vi lab5-at-remove-task.yml
ansible-doc at
ls -alrt
cat lab5-at-scheduled-task.yml
vi lab5-at-remove-task.yml
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ansible-playbook lab5-at-scheduled-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory 
ansible-playbook lab5-at-remove-task.yml -i ../inventory  -vvv
ls -alrt
ansible all -m shell -a "uptime"
ansible all -m shell -a "uptime" -i ../inventory 
cp -p ../ansible.cfg  .
ansible all -m shell -a "uptime" 
cp -p /home/ansible/plays/plays/vault_key .
ls -alrt
cp -p /home/ansible/plays/vault_key .
ls -alrt
pwd
ansible all -m shell -a "uptime" 
vi ansible.cfg 
pwd
ls -lart
ansible all -m shell -a "uptime" 
cp -p ../inventory .
ansible all -m shell -a "uptime" 
ls -lart
cat ansible.cfg 
vi lab6-selinux-enable.yml
ansible-playbook lab6-selinux-enable.yml
vi lab6-firewalld-enable.yml
ansible-playbook lab6-firewalld-enable.yml
cat lab6-firewalld-enable.yml
vi lab6-firewalld-enable.yml
ansible-playbook lab6-firewalld-enable.yml
vi lab6-firewalld-enable.yml
ansible-playbook lab6-firewalld-enable.yml
ls -lrt
date '+%s' -d '+ 30 days'
df -h
ls -lar
dmidecode -t1
sudo -i
df -h
uptime
lscpu
free -g
df -h
ps -ef
w
df -h
pwd
ps -ef
df -h
sudo -i
pwd
ls -alrt
cd plays/
ls -alrt
cat ansible.cfg 
pwd
cat inventory 
ansible all -m ping
mkdir lisenet
cp -p ansible.cfg lisenet/
cp -p inventory lisenet/
cd lisenet/
ls -lart
vi ansible.cfg 
pwd
mkdir roles
cat asn
cat ansible.cfg 
vi ansible.cfg
vi ansible.cfg 
ansible all -m ping -b
ansible all -m ping -b -vvv
ansible all -m setup 
ansible all -m setup  -b
vi ansible.cfg
ansible all -m setup 
ansible all -m setup --become-user=automation
vi ansible.cfg 
ansible all -m setup -b
cd ..
ls -lart
cat initial_setup.yml
ls -lart
cd lisenet/
ls -lart
pwd
cat inventory 
ls -alrt
vi adhoc.sh
ls -alrt ../../.ssh/id_rsa.pub 
ls -alrt ../../.ssh/authorized_keys 
vi adhoc.sh
chmod 755 adhoc.sh 
./adhoc.sh 
cat ansible.cfg 
vi ansible.cfg 
./adhoc.sh 
vi ansible.cfg 
vi adhoc.sh 
vi ansible.cfg 
./adhoc.sh 
vi ansible.cfg 
ansible servers -m ping
ansible servers -m ping -b
vi ansible.cfg 
ansible servers -m user -a "name=tae" -b
ls -lart
cat adhoc.sh 
mv adhoc.sh task2-adhoc.sh
ls -alrt
cat inventory 
vi task3-motd.yml
ansible-playbook task3-motd.yml
cat task3-motd.yml 
vi task3-motd.yml
cat inventory 
ls -lart
cat task3-motd.yml
ansible-playbook task3-motd.yml
cat task3-motd.yml 
ansible-playbook task3-motd.yml
ls -alrt
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
vi task4-ssh.yml
ansible-playbook task4-ssh.yml 
pwd
ls -alrt
vi ansible.cfg 
vi vault_key
vi secret.yml
ansible-vault encrypt secret.yml 
ansible-vault view secret.yml 
pwd
cat > user_list.yml
cat user_list.yml 
vi users.yml
ansible-vault users.yml
vi users.yml
ansible-vault users.yml --ask-vault-pass
ansible-playbook users.yml
pwd
ls -alrt
vi users.yml
ansible-playbook users.yml
cat inventory 
vi users.yml
ansible-playbook users.yml
cat users.yml 
ls -alrt
mv secret.yml task5-secret.yml
mv user_list.yml task5-user_list.yml
mv users.yml task5-users.yml
vi task5-users.yml
cat task5-user_list.yml
cat task5-users.yml 
ansible-playbook task5-users.yml
ls -lrt
cat ansible.cfg 
ansible-vault view task5-secret.yml
vi task5-users.yml\
ansible-vault view task5-secret.yml
ansible-playbook task5-users.yml
ls -lrt
cd ..
ls -alrt
cd lisenet/
ls -alrt
cat task3-motd.yml
cat task5-users.yml
vi task6-regular_tasks.yml
ansible-playbook task6-regular_tasks.yml
vi task6-regular_tasks.yml
ansible-playbook task6-regular_tasks.yml
vi task6-regular_tasks.yml
ansible-playbook task6-regular_tasks.yml
vi task6-regular_tasks.yml
ansible-playbook task6-regular_tasks.yml
pwd
vi task8-addrepo.yml
ansible-playbook task8-addrepo.yml
vi task8-addrepo.yml 
ansible-playbook task8-addrepo.yml
fdisk -l
sudo -i
pwd
cd ..
ls -alrt
grep role *
grep -ri role *
ls -alrt
cat lab5-at-scheduled-task.yml
more lab3-backup-logs.yml
ls -lrt
more lab6-firewalld-enable.yml
pwd
cd lisenet/
pwd
vi ansible.cfg 
cd roles/
ansible-galaxy init sample-mysql
ansible-galaxy init sample-apache
cd sample-mysql
ls -alrt
cd tasks
ls -alrt
vi main.yml 
cd ../handlers/
vi main.yml 
cd ..
cat tasks/main.yml 
vi tasks/main.yml
pwd
cd templates/
ls -alrt
cat > my.cnf.j2
ls -alrt
cat my.cnf.j2
cd ../
vi tasks/main.yml 
pwd
cd ..
pwd
cd ..
ls -alrt
vi task9-mysql.yml
ls -alrt
vi task9-mysql.yml
ansible-playbook task9-mysql.yml
pwd
cd roles/
cd sample-mysql/
cd tasks/
vi main.yml 
pwd
cd ..
pwd
cd ..
ls -alrt
cd ..
ls -alrt
vi task9-mysql.yml
cd roles/
ls -lart
cd ..
pwd
cat ansible.cfg 
vi task9-mysql.yml
ansible-playbook task9-mysql.yml
vi task9-mysql.yml
ansible-playbook task9-mysql.yml
cat inventory 
ls -alrt
vi task9-mysql.yml
ansible-playbook task9-mysql.yml
pwd
vi roles/sample-mysql/tasks/main.yml 
ansible-playbook task9-mysql.yml
vi roles/sample-mysql/tasks/main.yml 
vi roles/sample-mysql/handlers/main.yml 
vi roles/sample-mysql/tasks/main.yml 
ansible-playbook task9-mysql.yml
vi roles/sample-mysql/tasks/main.yml 
vi roles/sample-mysql/handlers/main.yml 
cat /root/.my.cnf
sudo cat /root/.my.cnf
ansible-playbook task9-mysql.yml
telnet juanpaolosantiago1c.mylabserver.com 3306
yum install telnet
sudo yum install telnet 
telnet juanpaolosantiago1c.mylabserver.com 3306
sudo telnet juanpaolosantiago1c.mylabserver.com 3306
telnet juanpaolosantiago1c.mylabserver.com 3306
sudo telnet juanpaolosantiago1c.mylabserver.com 3306
ssh juanpaolosantiago1c.mylabserver.com
nc juanpaolosantiago1c.mylabserver.com 3306
sudo -i
ls -alrt
cat task
cd roles/
cd sample-mysql/
ls -alrt
cat tasks/main.yml 
pwd
vi tasks/main.yml 
pwd
cd plays/
cd lisenet/
ls -lart
pwd
cat inventory 
pwd
cd roles/
ls -lart
cd sample-apache/
ls -lart
cd tasks/
vi main.yml 
cd ..
vi handlers/main.yml 
cat tasks/main.yml 
pwd
ls -alrt
cd templates/
vi index.html.j2
ansible -m setup localhost -b
ansible localhost -m setup -b
vi index.html.j2 
pwd
cd ..
ls -alrt
cd ..
ls -alrt
cd ..
pwd
ls -alrt
vi task10-apache.yml
ansible-playbook task10-apache.yml
vi task10-apache.yml
ansible-playbook task10-apache.yml
ls -lart
cat task9-mysql.yml
vi task10-apache.yml
ls -lart /home/cloud_user/ansible/plays/lisenet/roles/sample-apache
pwd
vi task10-apache.yml 
ansible-playbook task10-apache.yml
vi roles/sample-apache/tasks/main.yml 
ansible-playbook task10-apache.yml
curl http://juanpaolosantiago2c.mylabserver.com/index.html
curl -k https://juanpaolosantiago2c.mylabserver.com/index.html
ls -lart
pwd
cat task10-apache.yml
vi task10-apache.yml
pwd
ansible-playbook task10-apache.yml
curl -k https://juanpaolosantiago2c.mylabserver.com/index.html
vi roles/sample-apache/tasks/main.yml 
curl -k https://juanpaolosantiago2c.mylabserver.com/index.html
ansible-playbook task10-apache.yml
ls -alrt
curl -k https://juanpaolosantiago2c.mylabserver.com/index.html
curl http://juanpaolosantiago2c.mylabserver.com/index.html
ls -lart
cat task10-apache.yml
pwd
cd roles/sample-apache/
cat tasks/main.yml 
pwd
cd ..
l -lart
ls -lart
pwd
ansible-galaxy install geerlingguy.haproxy -p /home/ansible/plays/lisenet/roles
ls -lart
cd geerlingguy.haproxy
ls -alrt
cd ..
ls -alrt
pwd
cd ..
ls -alrt
vi inventory 
vi task10-apache.yml
ansible-playbook task10-apache.yml
pwd
ls -lart
cd roles/
ls -alrt
cd geerlingguy.haproxy
ls -lart
cd te
cd templates/
ls -lart
cat haproxy.cfg.j2
pwd
ls -lart
cd ..
ls -alrt
cd tasks/
ls -alrt
cat main.yml 
pwd
cd ../templates/
ls -alrt
cat haproxy.cfg.j2
pwd
cd ..
ls -lart
cat README.md 
pwd
cat defaults/main.yml 
vi defaults/main.yml
cat README.md 
vi defaults/main.yml
pwd
ls -lart
cd ..
pwd
ls -alrt
cd ..
ls -alrt
vi task11-haproxy.yml
pwd
ls -alrt roles/
cat task11-haproxy.yml
vi task11-haproxy.yml
ansible-playbook task11-haproxy.yml
pwd
ls -alrt
vi roles/geerlingguy.haproxy/defaults/main.yml 
pwd
vi lb.yml
vi task11-haproxy.yml
ansible-playbook task11-haproxy.yml
ls -lart
cat roles/geerlingguy.haproxy/tasks/main.yml 
ls -lrt /etc/haproxy/haproxy.cfg
cat /etc/haproxy/haproxy.cfg
ls -alrt
cat task11-haproxy.yml
cat lb.yml 
vi task11-haproxy.yml
vi roles/geerlingguy.haproxy/defaults/main.yml 
ansible-playbook task11-haproxy.yml
ls -alrt
vi roles/geerlingguy.haproxy/defaults/main.yml 
cat roles/geerlingguy.haproxy/tasks/main.yml 
pwd
ansible-playbook task11-haproxy.yml
vi roles/geerlingguy.haproxy/defaults/main.yml 
ansible-playbook task11-haproxy.yml
vi roles/geerlingguy.haproxy/defaults/main.yml 
ansible-playbook task11-haproxy.yml
vi roles/geerlingguy.haproxy/defaults/main.yml 
ansible-playbook task11-haproxy.yml
cat /etc/haproxy/haproxy.cfg 
curl http://localhost
curl http://localhost/index.html
cat /etc/haproxy/haproxy.cfg 
curl http://172.31.110.163:80
curl http://172.31.108.136:80
curl http://localhost/
curl http://localhost
elinks http://localost
elinks http://loca=host
elinks http://localhost
curl http://172.31.108.136:80
sudo -i
ls -alrt
pwd
cd roles/
ks -alrt
ls -alrt
ansible-galaxy init rhel_system
cd rhel_system/tasks/
vi main.yml 
cat main.yml 
pwd
cd ..
pwd
cd ..
ls -lart
vim selinux.yml
mv selinux.yml task12-selinux.yml
vi task12-selinux.yml
ls -alrt roles/rhel_system/
cat task12-selinux.yml
ansible-playbook task12-selinux.yml
df -h
ls -lart
git status
pwd
cd ..
pwd
cd ..
pwd
ls -alrt
git init 
git status
ls -alrt
git push https://github.com/paolopogi23/ex407.git
git --confit
git --config
pwd
cd .git
ls -alrt
vi config
git config --global user.name "paolopogi23"
git config user.name
pwd
cd..
pwd
cd ..
pwd
git remote add origin https://github.com/paolopogi23/ex407.git
ls -alrt
pwd
git push -u
git push
git status
pwd
git commit -a
git push
git config --global user.name "paolopogi23"
git config --global user.password "T0t0batoto123"
git push
pwd
git help config
pwd
cd .git
ls-alrt
ls -alrt
vi config 
git config credential.helper store
git push 
git checkout -b ansible
pwd
cd ..
ls -alrt
git checkout -b ansible
git push
git push origin master
git push -u origin master
pwd
ls -alrt
cd plays/
ls -alrt
git push -u origin master
git checkout master
git status
git branch
git checkout master
git checkout -b master
git status
git push -u origin master
git config --list
pwd
cd ..
pwd
cd .git
vi config 
cd ..
git status
git push
cd  .git/
vi config 
git push
cd ..
pwd
git remote add git@github.com:paolopogi23/ex407.git ansible
git remote set-url origin git@github.com:paolopogi23/ex407.git
git ls-remote
pwd
cd .ssh/
ls -alrt
cat id_rsa.pub
cd ..
git ls-remote
git push
git branch
git status
git push -u origin master
git push -u origin ansible
git push origin feature
git pull
 git branch --set-upstream-to=origin/ansible
 git branch --set-upstream-to=origin/master
 git branch --set-upstream-to=ansible
git remote -v
git push origin master
pwd
ls -alrt
git commit -a -m "Initial commit"
git add .
git status
cd plays/
ls -alrt
cd lisenet/
ls -lart
ansible-playbook task10-apache.yml
vi inventory 
vi ansible.cfg 
ansible-playbook task10-apache.yml
vi task10-apache.yml
chmod 755 inventory 
ls -alrt
chmod 755 *.yml
ls -alrt
ansible-playbook task10-apache.yml
chmod 755 ansible.cfg
ansible-playbook task10-apache.yml
pwd
cd ..
chmod 755 lisenet/
cd lisenet/
ansible-playbook task10-apache.yml
ls -alrt
chmod 744 vault_key
ls -alrt
ansible-playbook task10-apache.yml
cat vault_key
cat /home/ansible/plays/lisenet/vault_key
chmod 644 /home/ansible/plays/lisenet/vault_key
cat vault_key
ansible-playbook task10-apache.yml
vi inventory 
ansible-playbook task10-apache.yml
ansible all -m ping
ansible-playbook task10-apache.yml
pwd
ls -alrt
vi task10-apache.yml
cd roles/
ls -alrt
chmod 755 *
ls -alrt
cd sample-apache
ls -alrt
pwd
cd ..
chmod -R 755 *
cd -
;ls -alrt
ls -alrt
cd tasks/
vi main.yml 
pwd
cd ..
pwd
cd ..
ansible-playbook task10-apache.yml
ls -lart
pwd
cd ..
ls -alrt
cat lab2-httpd-firewall.yml
ansible-playbook lab2-httpd-firewall.yml
ansible-playbook lab2-httpd-firewall.yml -i inventory 
cd ..
sudo chmod 755 plays
ls -alrt
cd plays/
ls -alrt
chmod -R 755 *
ls -lart
cd lisenet/
ls -alrt
ansible-playbook task10-apache.yml
chmod 644 vault_key 
ansible-playbook task10-apache.yml
sudo tailf /var/log/haproxy/haproxy.log 
ls -art
ls -alrt
pwd
ls -alrt
df -h
ansible-playbook task12-selinux.yml
cat task5-users.yml
ls -alt
cat task9-mysql.yml
cat /home/ansible/plays/lisenet/roles/sample-mysql/tasks/main.yml 
ls -lqrt
cat task3-motd.yml
ansible-playbook task3-motd.yml
ls -alrt
cat task5-users.yml
ls -lart
pwd
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
sysctl -a | grep swap
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vim task13-sysctl.yml
cat task13-sysctl.yml
ls -lrt
pwd
cd ..
ls -alrt
grep block *
grep -ri block *
ls -alrt
pwd
grep -ri block | more
grep -ri block *
pwd
ls -alrt
grep block *.yml
cd lisenet/
grep block *.yml
cd ..
ls p-alrt
cd lisenet/
ls -alrt
cat task13-sysctl.yml
vi task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vi task13-sysctl.yml
ansible-playbook task13-sysctl.yml
vi task13-sysctl.yml
ls -alrt
ansible-playbook task13-sysctl.yml
cat task13-sysctl.yml
git status
pwd
cd ..
ls -alrt
rm -rf temp
git status
git rm temp
git rm -r temp
git status
git add .
git status
pwd
cd ..
git add .
git status
pwd
cd plays/
git branch
git checkout .bash_history .viminfo
git status
