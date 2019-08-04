FROM centos:7
LABEL maintainer="Gino Jansen"

ENV packages "ansible molecule docker yamllint ansible-lint flake8 testinfra"

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y update \
	&& yum -y install epel-release \
	&& yum -y install \
	python-pip \
	python-devel \
	@development \
 	&& yum clean all

RUN pip install $packages

RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]