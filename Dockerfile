FROM ubuntu:14.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
	&& apt-get update --quiet \
	&& apt-get upgrade --quiet --yes \
	&& apt-get install --quiet --yes --no-install-recommends openssh-server rsync \
	&& apt-get autoremove --yes \
	&& apt-get clean

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
ADD authorized_keys /root/.ssh/
RUN chmod 600 /root /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
