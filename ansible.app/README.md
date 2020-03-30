### How to run ansible-playbook
```
./build.sh
docker run -v $PWD:/ansible junos_ansible_app ansible-playbook -i inventory/ playbooks/vmm.yml
alias run_vmm="docker run -v $PWD:/ansible junos_ansible_app ansible-playbook"
run_vmm -i inventory/ playbooks/vmm.yml
```
