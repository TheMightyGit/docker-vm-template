FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y git curl man python jq vim openssh-server net-tools tmux sudo \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils \
    postgresql redis-server
RUN adduser --disabled-password --gecos "" {{ cookiecutter.username }}
RUN echo '{{ cookiecutter.username }} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /var/run/sshd

USER {{ cookiecutter.username }}
RUN mkdir ~/.bash && cd ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git
RUN echo 'export GITAWAREPROMPT=~/.bash/git-aware-prompt' >>~/.bash_profile
RUN echo 'source "${GITAWAREPROMPT}/main.sh"' >>~/.bash_profile
RUN echo 'export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >>~/.bash_profile
USER root

RUN apt-get install -y postgresql-server-dev-9.5
USER {{ cookiecutter.username }}
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN echo 'export PATH="~/.pyenv/bin:$PATH"' >>~/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >>~/.bash_profile
RUN echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bash_profile
RUN ~/.pyenv/bin/pyenv install -s 3.5.2
USER root

USER {{ cookiecutter.username }}
RUN echo 'export LC_ALL=C' >>~/.bash_profile
USER root

USER {{ cookiecutter.username }}
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
USER root

RUN apt-get install -y telnet iputils-ping

EXPOSE 22
EXPOSE 8080

ADD startup.sh startup.sh
ADD .vimrc /home/{{ cookiecutter.username }}/

ENTRYPOINT ["./startup.sh"]
