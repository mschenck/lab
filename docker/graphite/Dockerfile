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

# export http
EXPORT 80

# export carbon-cache
EXPORT 2003

# Start services
CMD cd /opt/lab/ansible ; ansible-playbook -i "localhost," -c local graphite.yml ; tail -f /var/log/nginx/*log /opt/graphite/storage/log/carbon-cache/*/*.log /opt/graphite/storage/log/webapp/*.log
