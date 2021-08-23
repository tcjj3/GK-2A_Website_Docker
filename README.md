# GK-2A_Website_Docker
Docker for website to show GK-2A's infomations.


# Quick Start

Install docker-ce, example given on Debian.

```
[tcjj3@debian]$ sudo apt install -y curl
[tcjj3@debian]$ curl -fsSL get.docker.com -o get-docker.sh
[tcjj3@debian]$ sudo sh get-docker.sh
[tcjj3@debian]$ sudo groupadd docker
[tcjj3@debian]$ sudo usermod -aG docker $USER
[tcjj3@debian]$ sudo systemctl enable docker && sudo systemctl start docker
```

Run GK-2A_Hirez_Docker.

```
[tcjj3@debian]$ sudo docker volume create xrit-rx
[tcjj3@debian]$ sudo docker volume create xrit-rx_website_config
[tcjj3@debian]$ sudo docker run -d -i -t \
 --restart always \
 --name=goesrecv_website \
 --device /dev/bus/usb \
 -e DASHBOARDSERVER="192.168.1.2:1692" \
 -e FILEBROWSERSERVER="192.168.1.2:8888" \
 -e THEME="dark" \
 -e HEADMSG="This is <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3</a>." \
 -e PROXY_DASHBOARD=true \
 -e CREATE_DASHBOARD_LINK=true \
 -e PROXY_FILEBROWSER=true \
 -e CREATE_FILEBROWSER_LINK=true \
 -p 5007:5005 \
 -p 8899:8888 \
 -v xrit-rx_website_config:/opt/xrit-rx_config \
 -v xrit-rx:/usr/local/bin/xrit-rx/src/received/LRIT \
 tcjj3/gk-2a_website_docker:latest
```

**If the `FILEBROWSERSERVER` environment variable is empty, then this image will start a "`filebrowser`" program to serve it.**
<br>
**The `THEME` environment variable can be "`light`", "`dark`" or just set a `filename` which is an exist file in the container.**
<br>
**The `HEADMSG` environment variable is to set the `Message` which you want to show at the `Top` of the website.**
<br>
**The other environment variables are just like in [https://github.com/tcjj3/GK-2A_Hirez_Docker](tcjj3/GK-2A_Hirez_Docker).**
