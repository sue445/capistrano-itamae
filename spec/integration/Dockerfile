# c.f. https://docs.docker.com/engine/examples/running_ssh_service/#build-an-eg_sshd-image
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server sudo
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Create deploy user
RUN groupadd deploy \
 && useradd --gid deploy --shell /bin/bash --create-home deploy \
 && echo 'deploy ALL=NOPASSWD: ALL' >> /etc/sudoers \
 && mkdir -m 700 -p /home/deploy/.ssh

COPY config/id_rsa.pub /home/deploy/.ssh/authorized_keys

RUN chmod 600 /home/deploy/.ssh/authorized_keys \
 && chown -R deploy /home/deploy/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
