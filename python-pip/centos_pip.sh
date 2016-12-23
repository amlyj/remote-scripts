#! /bin/sh
#author: king-aric
echo welcome follow me -- king-aric
sleep 1
env(){
if ! rpm -q curl
then
   yum -y install curl
fi

temp="/tmp/pipdir"

if [ ! -d $temp ]
then
   mkdir -p $temp
fi
}

install(){
cd $temp && curl -ssl -O https://bootstrap.pypa.io/ez_setup.py && python ez_setup.py && \
curl -ssl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py
if [ $? -eq 0 ]
then
  echo 'python pip install success!'
else
  rm -rf $temp
  echo 'error'
  exit
fi
rm -rf $temp
}
env
install

