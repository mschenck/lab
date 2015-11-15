FROM centos
MAINTAINER Michael Schenck <mschenck@gmail.com>

# Install git and ansible
RUN touch /var/lib/rpm/* ; \
    yum install -y python-setuptools python-devel gcc git

RUN easy_install pip ; \
    pip install ansible

# export http and carbon-cache
EXPOSE 80 2003

# Clone lab repo and run graphite playbook
RUN cd /opt ; \
    git clone https://github.com/mschenck/lab.git ; \
    cd /opt/lab/ansible ; \
    ansible-playbook -i "localhost," -c local graphite.yml


# start monit interactively
CMD [ "/usr/bin/monit", "-I" ]
