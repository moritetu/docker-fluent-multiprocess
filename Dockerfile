## -*- docker-image-name: "moritoru81/fluent-multiprocess" -*-
FROM centos:centos6

MAINTAINER Tohru Moriyasu <moritoru81@gmail.com>

# Setup centos
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum clean all
RUN yum history sync
RUN yum -y update
RUN yum -y upgrade

# Install supervisor
RUN yum -y install supervisor --enablerepo=epel

# Install td-agent
RUN rpm --import http://packages.treasuredata.com/GPG-KEY-td-agent
ADD ./templates/td.repo /etc/yum.repos.d/td.repo
RUN yum -y install td-agent
RUN mkdir -p /data/fluentd/logs

# Install fluentd plugins
RUN /usr/lib64/fluent/ruby/bin/fluent-gem install --no-ri --no-rdoc fluent-plugin-multiprocess

ADD ./templates/td-agent/td-agent.conf /etc/td-agent/td-agent.conf
ADD ./templates/td-agent/td-agent-24224.conf /etc/td-agent/td-agent-24224.conf
ADD ./templates/td-agent/td-agent-24225.conf /etc/td-agent/td-agent-24225.conf

ADD ./templates/supervisord.conf /etc/supervisord.conf

# Add utility scripts
ADD ./templates/start.sh /start.sh
ADD ./templates/event-test.sh /event-test.sh

CMD ["/bin/bash", "/start.sh"]
