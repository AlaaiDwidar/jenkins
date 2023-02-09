FROM ubuntu

USER root

RUN mkdir -p jenkins_home
RUN chmod 777 jenkins_home

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Africa/Cairo

RUN apt-get update

RUN apt-get install -y tzdata

RUN apt-get install -y openjdk-11-jdk

RUN apt-get install -y openssh-server


# Install dependencies required to install Docker
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add the Docker GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add the Docker repository
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the package repository again
RUN apt-get update

# Install Docker
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify the Docker installation
RUN docker --version

RUN useradd -ms /bin/bash jenkins
RUN usermod -aG docker jenkins

WORKDIR jenkins_home

CMD [ "/bin/bash" ]