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

Running an instance with dynamic port association

  docker run -d -P mschenck/graphite

### RPM builds

Copy `rpmbuild/DOT.rpmmacros` to `~/.rpmmacros`.

