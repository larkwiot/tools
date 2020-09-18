FROM debian:unstable

# This container just makes sure my scripts work on
# debian unstable system from a clean slate. It is
# not necessarily meant to be used directly, though
# it very well could be if you really wanted to

ADD ./apt /stuff/apt

WORKDIR /stuff

RUN apt update -y && \
    apt install $(cat ./apt/packages.txt) -y

RUN ./apt/keys.sh && \
    cp apt/sources.list /etc/apt/sources.list && \
    apt update -y && \
    apt install $(cat ./apt/pkgsfromrepos.txt) -y

ADD ./ /stuff

RUN ./misc/docker-compose.sh

RUN pip3 install -r ./pip/requirements.txt

RUN apt update -y
RUN apt full-upgrade -y
RUN apt autoremove -y

RUN cp ./shell/mine.zsh-theme ~/.oh-my-zsh/themes
RUN cp ./shell/.zshrc ~/.zshrc
RUN cp ./shell/.vimrc ~/.vimrc