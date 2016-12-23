#! /bin/sh

temp="/tmp/nginx"
version="1.8.1"
conf_file="/usr/local/nginx/conf/nginx.conf"

env(){
if [ ! -d $temp ];then
   mkdir -p $temp
fi

cd $temp && \
curl -ssl -O -L http://nginx.org/download/nginx-"$version".tar.gz && \
   tar zxvf nginx-"$version".tar.gz && \
   yum -y install gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel && \
   cd nginx-"$version" && ./configure --prefix=/usr/local/nginx  && \
   make && make install && \
   ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ && \
   rm -rf $temp
echo '安装成功'

}
echo "nginx $version 准备安装中．．．"
echo "welcome follow me --jun"
sleep 2

env

