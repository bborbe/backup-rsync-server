FROM ubuntu:16.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>

ENV HOME /root
ENV LANG en_US.UTF-8

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade --quiet --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends \
	locales \
	apt-transport-https \
	ca-certificates \
	openssh-server \
	rsync \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean
RUN locale-gen en_US.UTF-8

VOLUME ["/data"]

RUN mkdir /var/run/sshd
#RUN echo 'root:screencast' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir -p /root/.ssh
RUN chmod 700 /root /root/.ssh
COPY files/authorized_keys /root/.ssh/
RUN chmod 600 /root /root/.ssh/authorized_keys

COPY files/ssh_config /etc/ssh/
COPY files/sshd_config /etc/ssh/
RUN chmod 644 /etc/ssh/ssh_config /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
