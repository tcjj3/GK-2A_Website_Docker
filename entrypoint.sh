#!/bin/sh






stringLength() {
len=`echo "$1" | awk '{printf("%d", length($0))}'`
echo "$len"
}







#Dashboard_StaticFiles_ServerPath="127.0.0.1:1692"
#[ ! -z "$DASHBOARDSERVER" ] && Dashboard_StaticFiles_ServerPath="$DASHBOARDSERVER"
Dashboard_StaticFiles_ServerPath="127.0.0.1:4041"












if [ ! -z "$DASHBOARDSERVER" ]; then
	echo "$DASHBOARDSERVER" > /tmp/dashboardserver
else
	DASHBOARDSERVER="127.0.0.1:1692"
	rm -rf /tmp/dashboardserver
fi




if [ ! -z "$FILEBROWSERSERVER" ]; then
	echo "$FILEBROWSERSERVER" > /tmp/filebrowserserver
else
	FILEBROWSERSERVER="127.0.0.1:8888"
	rm -rf /tmp/filebrowserserver
fi






cp /opt/upstream-preview-custom-light.original.tpl /opt/upstream-preview-custom-light.tpl
cp /opt/upstream-preview-custom-dark.original.tpl /opt/upstream-preview-custom-dark.tpl

#if [ -z "$HEADMSG" ]; then
#HEADMSG="This is <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3</a>."
#fi

sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-light.tpl
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-dark.tpl






if [ -z "$THEME" ]; then
	THEME="upstream-preview-custom-light.tpl"
elif [ $THEME = "light" ]; then
	THEME="upstream-preview-custom-light.tpl"
elif [ $THEME = "dark" ]; then
	THEME="upstream-preview-custom-dark.tpl"
fi













cat << EOF > /etc/caddy/Caddyfile
0.0.0.0:5005 {
    root /usr/local/bin/xrit-rx/src/received/LRIT
    tls off
    gzip
    browse / ${THEME}
EOF






if [ $PROXY_DASHBOARD = "1" ]; then
	PROXY_DASHBOARD="true"
fi

if [ $PROXY_DASHBOARD = "0" ]; then
	PROXY_DASHBOARD="false"
fi

if [ $PROXY_DASHBOARD = "True" ]; then
	PROXY_DASHBOARD="true"
fi

if [ $PROXY_DASHBOARD = "False" ]; then
	PROXY_DASHBOARD="false"
fi

if [ $PROXY_DASHBOARD = "TRUE" ]; then
	PROXY_DASHBOARD="true"
fi

if [ $PROXY_DASHBOARD = "FALSE" ]; then
	PROXY_DASHBOARD="false"
fi

if [ $PROXY_DASHBOARD != "false" ] && [ ! -z "$PROXY_DASHBOARD" ]; then
cat << EOF >> /etc/caddy/Caddyfile
    
    
    proxy /dash ${Dashboard_StaticFiles_ServerPath} {
        without /dash
    }
    proxy /dashboard ${Dashboard_StaticFiles_ServerPath} {
        without /dashboard
    }
    proxy /db ${Dashboard_StaticFiles_ServerPath} {
        without /db
    }
    proxy /d ${Dashboard_StaticFiles_ServerPath} {
        without /d
    }
    proxy /xrit-rx ${Dashboard_StaticFiles_ServerPath} {
        without /xrit-rx
    }
    proxy /lrit-rx ${Dashboard_StaticFiles_ServerPath} {
        without /lrit-rx
    }
    proxy /hrit-rx ${Dashboard_StaticFiles_ServerPath} {
        without /hrit-rx
    }
    proxy /xritrx ${Dashboard_StaticFiles_ServerPath} {
        without /xritrx
    }
    proxy /lritrx ${Dashboard_StaticFiles_ServerPath} {
        without /lritrx
    }
    proxy /hritrx ${Dashboard_StaticFiles_ServerPath} {
        without /hritrx
    }
    proxy /xrit ${Dashboard_StaticFiles_ServerPath} {
        without /xrit
    }
    proxy /lrit ${Dashboard_StaticFiles_ServerPath} {
        without /lrit
    }
    proxy /hrit ${Dashboard_StaticFiles_ServerPath} {
        without /hrit
    }
    proxy /gk-2a ${Dashboard_StaticFiles_ServerPath} {
        without /gk-2a
    }
    proxy /gk2a ${Dashboard_StaticFiles_ServerPath} {
        without /gk2a
    }
    proxy /geo-kompsat-2a ${Dashboard_StaticFiles_ServerPath} {
        without /geo-kompsat-2a
    }
    proxy /geokompsat-2a ${Dashboard_StaticFiles_ServerPath} {
        without /geokompsat-2a
    }
    proxy /geo-kompsat2a ${Dashboard_StaticFiles_ServerPath} {
        without /geo-kompsat2a
    }
    proxy /geokompsat2a ${Dashboard_StaticFiles_ServerPath} {
        without /geokompsat2a
    }
    
    proxy /favicon.ico ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.css ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.css.map ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.scss ${Dashboard_StaticFiles_ServerPath}
    proxy /js/dash.js ${Dashboard_StaticFiles_ServerPath}
    proxy /js/tools.js ${Dashboard_StaticFiles_ServerPath}
    
    proxy /api ${DASHBOARDSERVER}
    proxy /api/current ${DASHBOARDSERVER}
    proxy /api/latest ${DASHBOARDSERVER}
    proxy /api/received ${DASHBOARDSERVER}
EOF

/etc/init.d/nginx start > /dev/null 2>&1 &
fi


if [ $CREATE_DASHBOARD_LINK = "1" ]; then
	CREATE_DASHBOARD_LINK="true"
fi

if [ $CREATE_DASHBOARD_LINK = "0" ]; then
	CREATE_DASHBOARD_LINK="false"
fi

if [ $CREATE_DASHBOARD_LINK = "True" ]; then
	CREATE_DASHBOARD_LINK="true"
fi

if [ $CREATE_DASHBOARD_LINK = "False" ]; then
	CREATE_DASHBOARD_LINK="false"
fi

if [ $CREATE_DASHBOARD_LINK = "TRUE" ]; then
	CREATE_DASHBOARD_LINK="true"
fi

if [ $CREATE_DASHBOARD_LINK = "FALSE" ]; then
	CREATE_DASHBOARD_LINK="false"
fi

if [ $CREATE_DASHBOARD_LINK != "false" ] && [ ! -z "$CREATE_DASHBOARD_LINK" ]; then
#touch /usr/local/bin/xrit-rx/src/received/LRIT/dashboard > /dev/null 2>&1
echo "This is just a link file and would delete anytime, so please do not save anything in it." > /usr/local/bin/xrit-rx/src/received/LRIT/dashboard
else
rm -rf /usr/local/bin/xrit-rx/src/received/LRIT/dashboard > /dev/null 2>&1
fi






if [ $PROXY_FILEBROWSER = "1" ]; then
	PROXY_FILEBROWSER="true"
fi

if [ $PROXY_FILEBROWSER = "0" ]; then
	PROXY_FILEBROWSER="false"
fi

if [ $PROXY_FILEBROWSER = "True" ]; then
	PROXY_FILEBROWSER="true"
fi

if [ $PROXY_FILEBROWSER = "False" ]; then
	PROXY_FILEBROWSER="false"
fi

if [ $PROXY_FILEBROWSER = "TRUE" ]; then
	PROXY_FILEBROWSER="true"
fi

if [ $PROXY_FILEBROWSER = "FALSE" ]; then
	PROXY_FILEBROWSER="false"
fi

if [ $PROXY_FILEBROWSER != "false" ] && [ ! -z "$PROXY_FILEBROWSER" ]; then
cat << EOF >> /etc/caddy/Caddyfile
    
    
    proxy /filebrowser ${FILEBROWSERSERVER} {
        without /filebrowser
    }
    proxy /file ${FILEBROWSERSERVER} {
        without /file
    }
    proxy /fb ${FILEBROWSERSERVER} {
        without /fb
    }
    redir /files/filebrowser /files
    redir /api/resources/filebrowser /api/resources/
    redir /files/file /files
    redir /api/resources/file /api/resources/
    redir /files/fb /files
    redir /api/resources/fb /api/resources/
    proxy /files ${FILEBROWSERSERVER}
    proxy /login ${FILEBROWSERSERVER}
    proxy /api/login ${FILEBROWSERSERVER}
    proxy /api/signup ${FILEBROWSERSERVER}
    proxy /api/renew ${FILEBROWSERSERVER}
    proxy /static/js ${FILEBROWSERSERVER}
    proxy /static/img ${FILEBROWSERSERVER}
    proxy /static/css ${FILEBROWSERSERVER}
    proxy /static/fonts ${FILEBROWSERSERVER}
    proxy /static ${FILEBROWSERSERVER}
    proxy /api/resources ${FILEBROWSERSERVER}
    proxy /settings ${FILEBROWSERSERVER}
    proxy /settings/ ${FILEBROWSERSERVER}
    proxy /settings/profile ${FILEBROWSERSERVER}
    proxy /api/shares ${FILEBROWSERSERVER}
    proxy /settings/users ${FILEBROWSERSERVER}
    proxy /api/users ${FILEBROWSERSERVER}
    proxy /settings/shares ${FILEBROWSERSERVER}
    proxy /settings/global ${FILEBROWSERSERVER}
    proxy /api/settings ${FILEBROWSERSERVER}
    proxy /api/preview/thumb ${FILEBROWSERSERVER}
    proxy /api/preview/big ${FILEBROWSERSERVER}
    proxy /api/raw ${FILEBROWSERSERVER}
    proxy /api/command ${FILEBROWSERSERVER} {
        websocket
        header_upstream -Origin
    }
    proxy /share ${FILEBROWSERSERVER}
    proxy /api/share ${FILEBROWSERSERVER}
    proxy /api/shares ${FILEBROWSERSERVER}
    proxy /api/public/share ${FILEBROWSERSERVER}
    proxy /api/public/dl ${FILEBROWSERSERVER}
    proxy /api/search ${FILEBROWSERSERVER}
EOF
fi


if [ $CREATE_FILEBROWSER_LINK = "1" ]; then
	CREATE_FILEBROWSER_LINK="true"
fi

if [ $CREATE_FILEBROWSER_LINK = "0" ]; then
	CREATE_FILEBROWSER_LINK="false"
fi

if [ $CREATE_FILEBROWSER_LINK = "True" ]; then
	CREATE_FILEBROWSER_LINK="true"
fi

if [ $CREATE_FILEBROWSER_LINK = "False" ]; then
	CREATE_FILEBROWSER_LINK="false"
fi

if [ $CREATE_FILEBROWSER_LINK = "TRUE" ]; then
	CREATE_FILEBROWSER_LINK="true"
fi

if [ $CREATE_FILEBROWSER_LINK = "FALSE" ]; then
	CREATE_FILEBROWSER_LINK="false"
fi

if [ $CREATE_FILEBROWSER_LINK != "false" ] && [ ! -z "$CREATE_FILEBROWSER_LINK" ]; then
#touch /usr/local/bin/xrit-rx/src/received/LRIT/files > /dev/null 2>&1
echo "This is just a link file and would delete anytime, so please do not save anything in it." > /usr/local/bin/xrit-rx/src/received/LRIT/files
else
rm -rf /usr/local/bin/xrit-rx/src/received/LRIT/files > /dev/null 2>&1
fi




cat << EOF >> /etc/caddy/Caddyfile
    
    
    header / Access-Control-Allow-Origin *
}
EOF












# Path to save "filebrowser.db"
#cd /usr/local/bin/xrit-rx/src > /dev/null 2>&1
cd /opt/xrit-rx_config > /dev/null 2>&1




tmp=`cat /tmp/filebrowserserver | head -n 1`
[ -z "$tmp" ] && /usr/local/bin/filebrowser -r /usr/local/bin/xrit-rx/src/received -p 8888 -a 0.0.0.0 > /dev/null 2>&1 &








# Path which is saving "*.tpl"
#cd /usr/local/bin/xrit-rx/src/received/LRIT > /dev/null 2>&1
cd /opt > /dev/null 2>&1




/usr/local/bin/caddy --conf=/etc/caddy/Caddyfile > /dev/null 2>&1










