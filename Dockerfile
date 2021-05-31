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
xvfb x11vnc i3
RUN apt update \
&& apt install -y gpg-agent \
&& curl LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& (dpkg -i ./google-chrome-stable_current_amd64.deb || apt-get install-fy) \
&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub |apt-key add \
&& rm google-chrome-stable_current_amd64.deb \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /workspace
VOLUME /workspace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
EXPOSE 9091 
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
