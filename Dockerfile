FROM centos:6.9
LABEL maintainer="Gino Jansen"

RUN yum makecache fast \
 && yum -y update \
 && yum -y install epel-release \
 && yum -y install \
      ansible \
      mlocate\
      sudo \
      python-pip \
 && yum clean all

RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

CMD ["/sbin/init"]