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

Run GK-2A_Website_Docker.

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
 -e TITLEADDITIONALTEXT=" - GK-2A Satellite Receive Server by tcjj3" \
 -e HEADMSG="This is <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3</a>." \
 -e FOOTERMSG="<h1>Copyright $(printf $(printf '\\%o' $(printf %08x 0xa9 | sed 's/../0x& /g')) | iconv -f UTF-32BE -t UTF-8) <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3</a></h1>" \
 -e USERS="Bob hiccup Amy beauty" \
 -e REALM="GK-2A Satellite Receive Server by tcjj3 (BG7XUD), please contract the site administrator for an account!"
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
**The `TITLEADDITIONALTEXT` environment variable is to set the `Additional Text` which you want to show at the `Title` of the website.**
<br>
**The `HEADMSG` environment variable is to set the `Message` which you want to show at the `Top` of the website.**
<br>
**The `FOOTERMSG` environment variable is to set the `Message` which you want to show at the `Footer` of the website.**
<br>
**The `USERS` environment variable is to set the `UserNames` and `Passwords` which you want to just authorize to access the website. Each `UserName` or `Password` is seperated with just a space. If this environment variable is not setted or setted to an empty value, then everyone can access to the website (not enable `basicauth`).**
<br>
**The `REALM` environment variable is to set the `Message` which you want to show in the `Login Dialog` of this website.**
<br>
**The other environment variables are just like in [tcjj3/GK-2A_Hirez_Docker](https://github.com/tcjj3/GK-2A_Hirez_Docker).**
