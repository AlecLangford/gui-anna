FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt update \
&& apt install -y --no-install-recommends \
curl \
wget \
supervisor \
sudo \
net-tools \
xonsh
RUN apt update \
&& apt install -y --no-install-recommends --allow-unauthenticated \
xvfb x11vnc i3 wget && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get -y install google-chrome-stable

RUN mkdir /workspace
VOLUME /workspace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
EXPOSE 9091 
CMD ["supervisord"]
