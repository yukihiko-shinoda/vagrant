#!/bin/bash
INSTALL_PATH_PIPEWORK=/usr/pipework

sudo yum install -y git
# ↓Dockerの設定ファイルが作成されないため http://shimakaze.hatenablog.com/entry/2015/04/02/103449
yum -y install libdevmapper.so.1.02
yum -y install bridge-utils
if [ ! -e $INSTALL_PATH_PIPEWORK ]; then
    git clone https://github.com/jpetazzo/pipework.git $INSTALL_PATH_PIPEWORK
    sudo ln -s $INSTALL_PATH_PIPEWORK/pipework /usr/bin/pipework
fi
