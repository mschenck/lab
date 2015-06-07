lab
===

Automation
----------

### Ansible

Local runs, i.e.:

    ansible-playbook -i "localhost," -c local graphite.yml


### Docker

Build from `Dockerfile` in each `docker/<role>/` directory.

I.e.
    docker build -t mschenck/graphite:latest .

### RPM builds

Copy `rpmbuild/DOT.rpmmacros` to `~/.rpmmacros`.

