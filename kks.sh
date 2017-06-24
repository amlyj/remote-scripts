#! /bin/bash

curl -ssL https://raw.githubusercontent.com/amlyj/remote-scripts/master/linux/kill_service > kks&&\
chmod +x ./kks&&\
sudo mv ./kks /usr/local/bin/&&\
echo -e '""\n   install success...\n   "please run kks" kill your service...\n'
