#!/bin/bash

#
# http://nginx.org/en/download.html
#
NGINX_VER=1.13.0

#
# https://github.com/pagespeed/ngx_pagespeed/releases
#
PAGESPEED_VER=1.12.34.2

apt-get install libgeoip-dev

if [ ! -d "/usr/local/install" ]; then
	mkdir -p /usr/local/install
fi

cd /usr/local/install/ 
wget http://nginx.org/download/nginx-$NGINX_VER.tar.gz
tar xzvf nginx-$NGINX_VER.tar.gz


mkdir ngx_pagespeed/
cd ngx_pagespeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/v$PAGESPEED_VER-beta.tar.gz
tar xzvf v$PAGESPEED_VER-beta.tar.gz 
cd ngx_pagespeed-$PAGESPEED_VER-beta/
wget https://dl.google.com/dl/page-speed/psol/$PAGESPEED_VER-x64.tar.gz
tar -xzvf $PAGESPEED_VER-x64.tar.gz

cd /usr/local/install/nginx-$NGINX_VER

./configure \
          --prefix=/etc/nginx \
          --sbin-path=/usr/sbin/nginx \
          --modules-path=/usr/lib/nginx/modules \
          --conf-path=/etc/nginx/nginx.conf \
          --error-log-path=/var/log/nginx/error.log \
          --http-log-path=/var/log/nginx/access.log \
          --pid-path=/var/run/nginx.pid \
          --lock-path=/var/run/nginx.lock \
          --http-client-body-temp-path=/var/cache/nginx/client_temp \
          --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
          --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
          --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
          --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
          --user=nginx \
          --group=nginx \
          --with-file-aio \
          --with-threads \
          --with-http_addition_module \
          --with-http_auth_request_module \
          --with-http_dav_module \
          --with-http_flv_module \
          --with-http_gunzip_module \
          --with-http_gzip_static_module \
          --with-http_mp4_module \
          --with-http_random_index_module \
          --with-http_realip_module \
          --with-http_secure_link_module \
          --with-http_slice_module \
          --with-http_ssl_module \
          --with-http_stub_status_module \
          --with-http_sub_module \
          --with-http_v2_module \
          --with-mail \
          --with-mail_ssl_module \
          --with-stream \
          --with-poll_module \
          --with-http_geoip_module \
          --with-http_gunzip_module \
          --with-stream_ssl_module \
          --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security' \
          --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now' \
          --add-module=/usr/local/install/ngx_pagespeed/ngx_pagespeed-$PAGESPEED_VER-beta

make
make install

cd /usr/local/install/ && (
	rm -rf nginx-$NGINX_VER.tar.gz
	rm -rf nginx-$NGINX_VER
	rm -rf ngx_pagespeed
)

service nginx restart
service nginx status
nginx -V
