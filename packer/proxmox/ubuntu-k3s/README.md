Ubuntu K3s
==========

This is a very minimal Proxmox image running K3s on Ubuntu.

## Usage

First initialize packer:

    packer init .


Then, build the image:

    packer build .

**NOTE:** To force a rebuild use:

     packer build -force .

