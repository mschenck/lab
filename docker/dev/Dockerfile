FROM centos:7

# Install ansible
RUN yum install -y python-setuptools python-devel gcc
RUN easy_install pip
RUN pip install ansible

# Install git
RUN yum install -y git

# Clone lab repo and run graphite playbook
RUN cd /opt ; git clone https://github.com/mschenck/lab.git
RUN cd /opt/lab/ansible ; ansible-playbook -i "localhost," -c local graphite.yml
RUN /etc/init.d/monit start

# export http, https and carbon-cache
EXPOSE 80 443 2003
