FROM debian:buster-slim

LABEL maintainer "Chaojun Tan <https://github.com/tcjj3>"

ADD upstream-preview-custom-light.original.tpl /opt/upstream-preview-custom-light.original.tpl
ADD upstream-preview-custom-dark.original.tpl /opt/upstream-preview-custom-dark.original.tpl
ADD upstream-preview-light.tpl /opt/upstream-preview-light.tpl
ADD upstream-preview-dark.tpl /opt/upstream-preview-dark.tpl
ADD upstream-preview.tpl /opt/upstream-preview.tpl
ADD upstream.tpl /opt/upstream.tpl
ADD entrypoint.sh /opt/entrypoint.sh

RUN export DIR_TMP="$(mktemp -d)" \
  && sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && apt-get update \
  || echo "continue..." \
  && apt-get install --no-install-recommends -y ca-certificates \
                                                curl \
                                                wget \
                                                unzip \
                                                git \
                                                nginx \
                                                vim \
                                                psmisc \
                                                procps \
  && chmod +x /opt/*.sh \
  && mkdir -p /etc/caddy \
  && mkdir -p /opt/xrit-rx_config \
  && git clone https://github.com/sam210723/xrit-rx /usr/local/bin/xrit-rx \
  && mkdir -p /usr/local/bin/xrit-rx/src/received \
  && pip3 install --no-cache-dir -r /usr/local/bin/xrit-rx/requirements.txt \
  && curl -L http://nmsc.kma.go.kr/resources/enhome/resources/satellites/coms/COMS_Decryption_Sample_Cpp.zip -o ${DIR_TMP}/COMS_Decryption_Sample_Cpp.zip \
  && unzip -j ${DIR_TMP}/COMS_Decryption_Sample_Cpp.zip EncryptionKeyMessage_001F2904C905.bin -d ${DIR_TMP} \
  && mv ${DIR_TMP}/EncryptionKeyMessage_001F2904C905.bin /usr/local/bin/xrit-rx/src/EncryptionKeyMessage_001F2904C905.bin \
  && python3 /usr/local/bin/xrit-rx/src/tools/keymsg-decrypt.py /usr/local/bin/xrit-rx/src/EncryptionKeyMessage_001F2904C905.bin 001F2904C905 \
  && cp /usr/local/bin/xrit-rx/src/xrit-rx.py /usr/local/bin/xrit-rx/src/xrit-rx.bak.py \
  && cp /usr/local/bin/xrit-rx/src/demuxer.py /usr/local/bin/xrit-rx/src/demuxer.bak.py \
  && cp /usr/local/bin/xrit-rx/src/ccsds.py /usr/local/bin/xrit-rx/src/ccsds.bak.py \
  && tmp=`grep "except OSError:" /usr/local/bin/xrit-rx/src/xrit-rx.py` || echo "continue..." \
  && [ -z "$tmp" ] && sed -Ei "s#except ConnectionResetError:#except OSError:\n                print(Fore.WHITE + Back.RED + Style.BRIGHT + \"CONNECTION DOES NOT EXIST\")\n                safe_stop()\n            except ConnectionResetError:#gi" /usr/local/bin/xrit-rx/src/xrit-rx.py || echo "continue..." \
  && tmp=`grep "except Exception as e:" /usr/local/bin/xrit-rx/src/xrit-rx.py | awk 'END{print NR}'` || echo "continue..." \
  && [ $((tmp)) -lt 2 ] && sed -i ':a;N;$!ba; s#\(.*\)safe_stop()\(.*\)#\1safe_stop()\nexcept Exception as e:\n    print(e)\n    safe_stop()\2#gi' /usr/local/bin/xrit-rx/src/xrit-rx.py || echo "continue..." \
  && tmp=`grep "self.demuxer.lastImage = self.cProduct.last" /usr/local/bin/xrit-rx/src/demuxer.py | awk 'END{print NR}'` || echo "continue..." \
  && [ $((tmp)) -lt 2 ] && sed -i ':a;N;$!ba; s#\(.*\)self.cProduct = None\(.*\)#\1self.demuxer.lastImage = self.cProduct.last\n                self.cProduct = None\2#gi' /usr/local/bin/xrit-rx/src/demuxer.py || echo "continue..." \
  && tmp=`grep "except ValueError:" /usr/local/bin/xrit-rx/src/ccsds.py` || echo "continue..." \
  && [ -z "$tmp" ] && (sed -Ei "s/self.PLAINTEXT = self.headerField \+ decData/#self.PLAINTEXT = self.headerField + decData/gi" /usr/local/bin/xrit-rx/src/ccsds.py && tmp=`grep "import colorama" /usr/local/bin/xrit-rx/src/ccsds.py` || echo "continue..." && ([ -z "$tmp" ] && sed -Ei "s#import os#import os\n\nimport colorama\nfrom colorama import Fore, Back, Style#gi" /usr/local/bin/xrit-rx/src/ccsds.py && sed -Ei "s#decData = decoder.decrypt\(self.dataField\)#try:\n            decData = decoder.decrypt(self.dataField)\n            self.PLAINTEXT = self.headerField + decData\n        except ValueError:\n            print(\"    \" + Fore.WHITE + Back.RED + Style.BRIGHT + \"DES ECB DECRYPT ERROR:   ValueError\")\n        else:\n            decData = None#gi" /usr/local/bin/xrit-rx/src/ccsds.py) || sed -Ei "s#decData = decoder.decrypt\(self.dataField\)#try:\n            decData = decoder.decrypt(self.dataField)\n            self.PLAINTEXT = self.headerField + decData\n        except ValueError:\n            print(\"    \" + \"DES ECB DECRYPT ERROR:   ValueError\")\n        else:\n            decData = None#gi" /usr/local/bin/xrit-rx/src/ccsds.py) || echo "continue..." \
  && pip3 install --no-cache-dir imageio \
  && mkdir -p /etc/nginx || echo "continue..." \
  && mkdir -p /etc/nginx/sites-available || echo "continue..." \
  && mkdir -p /etc/nginx/sites-enabled || echo "continue..." \
  && touch /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "server {" > /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	listen 4041 default_server;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	listen [::]:4041 default_server;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	root /usr/local/bin/xrit-rx/src/html;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	index index.html index.htm;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	server_name _;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	location / {" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "		try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	}" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "	" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && echo "}" >> /etc/nginx/sites-available/dashboard_staticfiles || echo "continue..." \
  && ln -s /etc/nginx/sites-available/dashboard_staticfiles /etc/nginx/sites-enabled/dashboard_staticfiles || echo "continue..." \
  && if [ "$(dpkg --print-architecture)" = "armhf" ]; then \
        ARCH="arm7"; \
     else \
        ARCH=$(dpkg --print-architecture); \
     fi \
  && mkdir -p ${DIR_TMP}/caddy \
  && curl -L -o ${DIR_TMP}/caddy/caddy.tar.gz https://github.com/caddyserver/caddy/releases/download/v1.0.4/caddy_v1.0.4_linux_${ARCH}.tar.gz \
  && tar -zxf ${DIR_TMP}/caddy/caddy.tar.gz -C ${DIR_TMP}/caddy \
  && mv ${DIR_TMP}/caddy/caddy /usr/local/bin/caddy \
  && curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash \
  && chmod +x /opt/* /usr/local/bin/xrit-rx/src/xrit-rx.py \
  && rm -rf ${DIR_TMP} \
  && apt-get autoremove --purge unzip git -y





ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]






