#!/bin/sh






stringLength() {
len=`echo "$1" | awk '{printf("%d", length($0))}'`
echo "$len"
}







/etc/init.d/cron restart > /dev/null 2>&1







#Dashboard_StaticFiles_ServerPath="127.0.0.1:1692"
#[ ! -z "$DASHBOARDSERVER" ] && Dashboard_StaticFiles_ServerPath="$DASHBOARDSERVER"
Dashboard_StaticFiles_ServerPath="127.0.0.1:4041"


#Dashboard_StaticFiles_ServerPath_Coloured="127.0.0.1:1692"
#[ ! -z "$DASHBOARDSERVER" ] && Dashboard_StaticFiles_ServerPath_Coloured="$DASHBOARDSERVER"
Dashboard_StaticFiles_ServerPath_Coloured="127.0.0.1:4042"


#Latest_Images_ServerPath="127.0.0.1:1692/received/LRIT"
#[ ! -z "$Latest_Images_ServerPath" ] && Latest_Images_ServerPath="$DASHBOARDSERVER"
Latest_Images_ServerPath="127.0.0.1:4043"












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
cp /opt/upstream-preview-custom-light-auth.original.tpl /opt/upstream-preview-custom-light-auth.tpl
cp /opt/upstream-preview-custom-dark-auth.original.tpl /opt/upstream-preview-custom-dark-auth.tpl
cp /opt/404.original.htm /opt/404.htm
cp /opt/401.original.htm /opt/401.htm

cp /opt/LatestImage.htm /opt/LatestFullDisk.htm
cp /opt/LatestImage.htm /opt/LatestFullDisk-fc.htm
cp /opt/LatestImage.htm /opt/LatestMerged.htm
cp /opt/LatestImage.htm /opt/LatestImage.new.htm


#if [ -z "$TITLEADDITIONALTEXT" ]; then
#TITLEADDITIONALTEXT=" - GK-2A Satellite Receive Server by tcjj3 (BG7XUD)"
#fi

#if [ -z "$HEADMSG" ]; then
#HEADMSG="This is <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3 (BG7XUD)</a>."
#fi

#if [ -z "$FOOTERMSG" ]; then
#FOOTERMSG="<h1>Copyright $(python3 -c "print(\"\xa9\")") <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3 (BG7XUD)</a></h1>"
#FOOTERMSG="<h1>Copyright $(printf $(printf '\\%o' $(printf %08x 0xa9 | sed 's/../0x& /g')) | iconv -f UTF-32BE -t UTF-8) <a rel=\"noopener noreferrer\" href=\"https://github.com/tcjj3\">tcjj3 (BG7XUD)</a></h1>"
#fi


sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/upstream-preview-custom-light.tpl
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/upstream-preview-custom-dark.tpl
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/upstream-preview-custom-light-auth.tpl
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/upstream-preview-custom-dark-auth.tpl
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/404.htm
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/401.htm

sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-light.tpl
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-dark.tpl
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-light-auth.tpl
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/upstream-preview-custom-dark-auth.tpl
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/404.htm
sed -i "s#HEADMESSAGESINTHEMEBYTCJJ3#$HEADMSG#gi" /opt/401.htm

sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/upstream-preview-custom-light.tpl
sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/upstream-preview-custom-dark.tpl
sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/upstream-preview-custom-light-auth.tpl
sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/upstream-preview-custom-dark-auth.tpl
sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/404.htm
sed -i "s#FOOTERMESSAGESINTHEMEBYTCJJ3#$FOOTERMSG#gi" /opt/401.htm




sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/LatestFullDisk.htm
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/LatestFullDisk-fc.htm
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/LatestMerged.htm
sed -i "s#TITLEADDITIONALTEXTINTHEMEBYTCJJ3#$TITLEADDITIONALTEXT#gi" /opt/LatestImage.new.htm

sed -i "s#LatestImage.js#LatestFullDisk.js#gi" /opt/LatestFullDisk.htm
sed -i "s#LatestImage.js#LatestFullDisk-fc.js#gi" /opt/LatestFullDisk-fc.htm
sed -i "s#LatestImage.js#LatestMerged.js#gi" /opt/LatestMerged.htm
#sed -i "s#LatestImage.js#LatestImage.js#gi" /opt/LatestImage.new.htm

sed -i "s#LatestImage#LatestFullDisk#gi" /opt/LatestFullDisk.htm
sed -i "s#LatestImage#LatestFullDisk-fc#gi" /opt/LatestFullDisk-fc.htm
sed -i "s#LatestImage#LatestMerged#gi" /opt/LatestMerged.htm
#sed -i "s#LatestImage#LatestImage#gi" /opt/LatestImage.new.htm






if [ -z "$USERS" ]; then
if [ -z "$THEME" ]; then
	THEME="upstream-preview-custom-light.tpl"
elif [ $THEME = "light" ]; then
	THEME="upstream-preview-custom-light.tpl"
elif [ $THEME = "dark" ]; then
	THEME="upstream-preview-custom-dark.tpl"
fi
else
if [ -z "$THEME" ]; then
	THEME="upstream-preview-custom-light-auth.tpl"
elif [ $THEME = "light" ]; then
	THEME="upstream-preview-custom-light-auth.tpl"
elif [ $THEME = "dark" ]; then
	THEME="upstream-preview-custom-dark-auth.tpl"
fi
fi













cat << EOF > /etc/caddy/Caddyfile
0.0.0.0:5005 {
    root /usr/local/bin/xrit-rx/src/received/LRIT
    tls off
    gzip
EOF








# Path which is saving "*.tpl"
#cd /usr/local/bin/xrit-rx/src/received/LRIT > /dev/null 2>&1
cd /opt > /dev/null 2>&1


if [ -f "${THEME}" ]; then
cat << EOF >> /etc/caddy/Caddyfile
    
    browse / ${THEME}
EOF
fi








cat << EOF >> /etc/caddy/Caddyfile
    
    
    errors {
        404 /opt/404.htm
        401 /opt/401.htm
    }
EOF






if [ ! -z "$USERS" ]; then

if [ -z "$REALM" ]; then
#REALM="GK-2A Satellite Receive Server by tcjj3 (BG7XUD), please contract the site administrator for an account!"
REALM="GK-2A Satellite Receive Server, please contract the site administrator for an account!"
fi

USERSLIST=`echo "$USERS" | sed "s/  / /gi" | sed "s/  / /gi" | sed "s/ /\n/gi" | awk -F ' ' 'BEGIN {count=0} {if ($0 != "") {count+=1; print $0; if (count > 1 && count % 2 == 0) {print '\n'}}}' | sed ":a;N;s/\n/ /gi;$!ba" | sed "s#  # {\n        realm \"$REALM\"\n        /\n    }\n    basicauth #gi"`

USERSLIST=`echo "    basicauth $USERSLIST{\n        realm \"$REALM\"\n        /\n    }"`

cat << EOF >> /etc/caddy/Caddyfile
    
$USERSLIST
EOF

fi










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
    
    proxy /dash_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /dash_coloured
    }
    proxy /dashboard_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /dashboard_coloured
    }
    proxy /db_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /db_coloured
    }
    proxy /d_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /d_coloured
    }
    proxy /xrit-rx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /xrit-rx_coloured
    }
    proxy /lrit-rx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /lrit-rx_coloured
    }
    proxy /hrit-rx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /hrit-rx_coloured
    }
    proxy /xritrx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /xritrx_coloured
    }
    proxy /lritrx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /lritrx_coloured
    }
    proxy /hritrx_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /hritrx_coloured
    }
    proxy /xrit_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /xrit_coloured
    }
    proxy /lrit_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /lrit_coloured
    }
    proxy /hrit_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /hrit_coloured
    }
    proxy /gk-2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /gk-2a_coloured
    }
    proxy /gk2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /gk2a_coloured
    }
    proxy /geo-kompsat-2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /geo-kompsat-2a_coloured
    }
    proxy /geokompsat-2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /geokompsat-2a_coloured
    }
    proxy /geo-kompsat2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /geo-kompsat2a_coloured
    }
    proxy /geokompsat2a_coloured ${Dashboard_StaticFiles_ServerPath_Coloured} {
        without /geokompsat2a_coloured
    }
    
    proxy /favicon.ico ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.css ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.css.map ${Dashboard_StaticFiles_ServerPath}
    proxy /css/dash.scss ${Dashboard_StaticFiles_ServerPath}
    proxy /js/dash.js ${Dashboard_StaticFiles_ServerPath}
    proxy /js/dash_coloured.js ${Dashboard_StaticFiles_ServerPath_Coloured}
    proxy /js/dash.bak.js ${Dashboard_StaticFiles_ServerPath_Coloured}
    proxy /js/tools.js ${Dashboard_StaticFiles_ServerPath}
    
    proxy /api $DASHBOARDSERVER
    proxy /api/current $DASHBOARDSERVER
    proxy /api/latest $DASHBOARDSERVER
    proxy /api/received $DASHBOARDSERVER
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

#touch /usr/local/bin/xrit-rx/src/received/LRIT/dashboard_coloured > /dev/null 2>&1
echo "This is just a link file and would delete anytime, so please do not save anything in it." > /usr/local/bin/xrit-rx/src/received/LRIT/dashboard_coloured
else
rm -rf /usr/local/bin/xrit-rx/src/received/LRIT/dashboard > /dev/null 2>&1
rm -rf /usr/local/bin/xrit-rx/src/received/LRIT/dashboard_coloured > /dev/null 2>&1
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






if [ $SHOW_LATESTIMAGES = "1" ]; then
	SHOW_LATESTIMAGES="true"
fi

if [ $SHOW_LATESTIMAGES = "0" ]; then
	SHOW_LATESTIMAGES="false"
fi

if [ $SHOW_LATESTIMAGES = "True" ]; then
	SHOW_LATESTIMAGES="true"
fi

if [ $SHOW_LATESTIMAGES = "False" ]; then
	SHOW_LATESTIMAGES="false"
fi

if [ $SHOW_LATESTIMAGES = "TRUE" ]; then
	SHOW_LATESTIMAGES="true"
fi

if [ $SHOW_LATESTIMAGES = "FALSE" ]; then
	SHOW_LATESTIMAGES="false"
fi

if [ $SHOW_LATESTIMAGES != "false" ] && [ ! -z "$SHOW_LATESTIMAGES" ]; then
touch /tmp/showlatestimages > /dev/null 2>&1 &

cat << EOF >> /etc/caddy/Caddyfile
    
    proxy /LatestFullDisk.jpg ${Latest_Images_ServerPath}
    proxy /LatestFullDisk.txt ${Latest_Images_ServerPath}
    proxy /LatestFullDisk.js ${Latest_Images_ServerPath}
    proxy /LatestFullDisk.json ${Latest_Images_ServerPath}
    proxy /LatestFullDisk.htm ${Latest_Images_ServerPath}
    proxy /LatestFullDisk-fc.jpg ${Latest_Images_ServerPath}
    proxy /LatestFullDisk-fc.txt ${Latest_Images_ServerPath}
    proxy /LatestFullDisk-fc.js ${Latest_Images_ServerPath}
    proxy /LatestFullDisk-fc.json ${Latest_Images_ServerPath}
    proxy /LatestFullDisk-fc.htm ${Latest_Images_ServerPath}
    proxy /LatestMerged.gif ${Latest_Images_ServerPath}
    proxy /LatestMerged.txt ${Latest_Images_ServerPath}
    proxy /LatestMerged.js ${Latest_Images_ServerPath}
    proxy /LatestMerged.json ${Latest_Images_ServerPath}
    proxy /LatestMerged.htm ${Latest_Images_ServerPath}
    proxy /LatestImage.jpg ${Latest_Images_ServerPath}
    proxy /LatestImage.txt ${Latest_Images_ServerPath}
    proxy /LatestImage.js ${Latest_Images_ServerPath}
    proxy /LatestImage.json ${Latest_Images_ServerPath}
    proxy /LatestImage.htm ${Latest_Images_ServerPath}
EOF

/opt/latest_image_links.sh > /dev/null 2>&1 &
else
rm -f /tmp/showlatestimages > /dev/null 2>&1 &
fi


if [ $CREATE_LATESTIMAGES_LINKS = "1" ]; then
	CREATE_LATESTIMAGES_LINKS="true"
fi

if [ $CREATE_LATESTIMAGES_LINKS = "0" ]; then
	CREATE_LATESTIMAGES_LINKS="false"
fi

if [ $CREATE_LATESTIMAGES_LINKS = "True" ]; then
	CREATE_LATESTIMAGES_LINKS="true"
fi

if [ $CREATE_LATESTIMAGES_LINKS = "False" ]; then
	CREATE_LATESTIMAGES_LINKS="false"
fi

if [ $CREATE_LATESTIMAGES_LINKS = "TRUE" ]; then
	CREATE_LATESTIMAGES_LINKS="true"
fi

if [ $CREATE_LATESTIMAGES_LINKS = "FALSE" ]; then
	CREATE_LATESTIMAGES_LINKS="false"
fi

if [ $CREATE_LATESTIMAGES_LINKS != "false" ] && [ ! -z "$CREATE_LATESTIMAGES_LINKS" ]; then
touch /tmp/createlatestimageslinks > /dev/null 2>&1 &
else
rm -f /tmp/createlatestimageslinks > /dev/null 2>&1 &
fi






if [ ! -z "$LATESTFULLDISK_CALLBACK" ]; then
echo "$LATESTFULLDISK_CALLBACK" > /tmp/latestfulldiskcallback
else
rm -f /tmp/latestfulldiskcallback > /dev/null 2>&1 &
fi


if [ ! -z "$LATESTFULLDISKFC_CALLBACK" ]; then
echo "$LATESTFULLDISKFC_CALLBACK" > /tmp/latestfulldiskfccallback
else
rm -f /tmp/latestfulldiskfccallback > /dev/null 2>&1 &
fi


if [ ! -z "$LATESTMERGED_CALLBACK" ]; then
echo "$LATESTMERGED_CALLBACK" > /tmp/latestmergedcallback
else
rm -f /tmp/latestmergedcallback > /dev/null 2>&1 &
fi


if [ ! -z "$LATESTIMAGE_CALLBACK" ]; then
echo "$LATESTIMAGE_CALLBACK" > /tmp/latestimagecallback
else
rm -f /tmp/latestimagecallback > /dev/null 2>&1 &
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










