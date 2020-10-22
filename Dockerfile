FROM fedora:32
ADD ./install.sh /usr/local
ADD ./vimrc /root/.vimrc

RUN /usr/local/install.sh
