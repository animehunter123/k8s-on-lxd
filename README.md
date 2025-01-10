# Description

Attempting to build a simple k8s cluster but on a single lxd host instead of physical or hypervisor hosts, instead primarily relying on the powerful "Dummy" module built into the Kernel (see kernel.org). My goal is basically 1 physical VM that will act as a host for >2 ControlPlanes and >3 Nodes -- I.e. A poor mans of emulating raspberry pis, all-in-a-box.

This was inspired by LearnLinuxTV, see his channel/vid: https://www.youtube.com/watch?v=U1VzcjCB_sY

![Sample Photo of Lxd Kubernetes (k8s) Environment](https://github.com/user-attachments/assets/7b758110-0f8b-466c-b2cc-26072c171598 "A sample photo of the lxd environment running kuberenetes (k8s)")

# How to Install

* Install Lxd
* Create several lxd containers matching the hostnames in ./inventory.ini
* Ensure you already ssh key copied to each of them, and they are added to your dns or /etc/hosts, so that you can just type "ssh k8sctl01" and it logs in automatically. This must be done before proceeding.
* Make sure you understand Kubernetes Basics! Ensure these Ports are available on your host, see: https://kubernetes.io/docs/reference/networking/ports-and-protocols/
* Run the ./start-k8s*.sh and follow the prompts, you should have a "Internal K8s Cluster" on your host (internal only) when done. Then you can deploy nginx hello or other webapps or microservices

