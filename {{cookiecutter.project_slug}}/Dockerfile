FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
    git \
    curl \
    man \
    python \
    jq \
    vim \
    openssh-server \
    net-tools \
    tmux sudo \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    postgresql \
    redis-server \
    postgresql-server-dev-9.5 \
    telnet \
    iputils-ping \
    supervisor

RUN mkdir -p /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN adduser --uid {{ cookiecutter.UID }} --disabled-password --gecos "" {{ cookiecutter.username }}
RUN echo '{{ cookiecutter.username }} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sed -i.bak -e s/peer/trust/g -e s/md5/trust/g /etc/postgresql/9.5/main/pg_hba.conf

RUN apt-get install -y apt-transport-https ca-certificates
RUN sudo apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
RUN apt-get update
# RUN apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
RUN apt-get install -y docker-engine
RUN gpasswd -a {{ cookiecutter.username }} docker

USER {{ cookiecutter.username }}
RUN mkdir ~/.bash && cd ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git
RUN echo 'export GITAWAREPROMPT=~/.bash/git-aware-prompt' >>~/.bash_profile
RUN echo 'source "${GITAWAREPROMPT}/main.sh"' >>~/.bash_profile
RUN echo 'export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >>~/.bash_profile

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN echo 'export PATH="~/.pyenv/bin:$PATH"' >>~/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >>~/.bash_profile
RUN echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bash_profile
RUN ~/.pyenv/bin/pyenv install -s 3.5.2

RUN echo 'export LC_ALL=C' >>~/.bash_profile
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

USER {{ cookiecutter.username }}
ADD .vimrc /home/{{ cookiecutter.username }}/

EXPOSE 22 80 443 8000 8080

USER root
ENTRYPOINT /usr/bin/supervisord
