#! /bin/bash
#centos 7
#author king-aric

softpath=/usr/local/
version=3.2.3
srcdir=/tmp/redis$version

for lib in tar gcc tcl make
do
  if ! rpm -q $lib ;then  yum -y install $lib ;fi
done

mkdir -p $srcdir && \
    cd $srcdir && \
    curl -ssl -O -L https://github.com/antirez/redis/archive/$version'.tar.gz' && \
    tar zxvf $version'.tar.gz' -C $softpath && cd $softpath'redis-'$version

make MALLOC=libc 
if make test || true
then
    make && make install 
else 
   echo 'error: 编译未通过'
   rm -rf $srcdir 
   rm -rf $softpath'redis-'$version
   exit
fi

if [ $? -eq 0 ];then 
    sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g"  $softpath'redis-'$version'/redis.conf'
    sed -i "s/dir .\//dir \/opt\/redis\/data/g"  $softpath'redis-'$version'/redis.conf'
    sed -i "s/protected-mode yes/protected-mode no/g" $softpath'redis-'$version'/redis.conf'
    sed -i "s/daemonize no/daemonize yes/g" $softpath'redis-'$version'/redis.conf' 
fi
$softpath'redis-'$version'/src/redis-server' $softpath'redis-'$version'/redis.conf'

