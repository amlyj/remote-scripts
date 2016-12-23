#! /bin/bash
#keepalived 安装脚本 

softroot='/usr/local'
version='1.2.20'
configroot='/etc/keepalived'
temp='/tmp/keepalived'

uninstall(){
file='keepalived*'
for d in '/sbin' '/usr/sbin' '/etc/init.d' '/etc/sysconfig'
do
   rm -f $d'/'$file
done
rm -rf $configroot
rm -rf $softroot'/'$file
if [ $# == 1 ];then
  echo '卸载完成...'
  exit
fi
}

config(){
echo '设置配置文件目录:'$configroot
mkdir -p $configroot 
cp $softroot'/keepalived/etc/keepalived/keepalived.conf'  $configroot
cp $softroot'/keepalived/etc/rc.d/init.d/keepalived' /etc/init.d/
cp $softroot'/keepalived/etc/sysconfig/keepalived'  /etc/sysconfig/
echo '设置软连接'
ln -s $softroot'/keepalived/sbin/keepalived'  /sbin/
#ln -s $softroot'/sbin/keepalived'  /usr/sbin/
echo '设置开机启动'
chkconfig keepalived on
echo '配置完成'
}

install(){
uninstall
#env
for e in gcc openssl openssl-devel tar
do
  if ! rpm -q $e ;then
     yum -y install $e
  fi
done
if [ ! -d $temp ];then mkdir -p $temp; fi && \
cd $temp && \
curl -ssl -O -L 'https://github.com/acassen/keepalived/archive/v'$version'.tar.gz'
if [ $? -ne 0 ];then echo 'error：软件包下载失败！'; exit; fi
tar zxvf 'v'$version'.tar.gz' && cd 'keepalived-'$version && ./configure -prefix=$softroot'/keepalived'
if make && make install ; then
   echo '安装完成，安装目录:'$softroot'/keepalived'
else
   echo '安装失败，编译未通过'
   exit
fi
config
rm -rf $temp
}
install
