# Deploy kubernetes cluster using Ansible

- Tested on Centos 7

Requirements:

  - Deployment environment has Ansible
  - Master and Nodes must have passwordless SSH access

# Usage

Add the cluster information into a file `inventories/centos-inventory`
```
[master]
192.168.122.238   ansible_hostname=master

[nodes]
192.168.122.38   ansible_hostname=node01
192.168.122.80   ansible_hostname=node02

[k8s-cluster:children]
master
nodes
```

After the above setup, run `install.yml` playbook:

```
ansible-playbook install.yml
```

After the above install, run `validate-cluster.yml` playbook:

```
ansible-playbook validate-cluster.yml
```

# Reset the cluster

Reset all the cluster nodes state using `reset-cluster.yml` playbook:

```
ansible-playbook reset-cluster.yml
```
