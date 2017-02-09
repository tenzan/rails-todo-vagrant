#!/usr/bin/env bash

sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list
sudo -H -u ubuntu bash -i -c 'curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -'

sudo apt-get -y update
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libreadline-dev nodejs >> /dev/null 2>&1
sudo npm install -g bower
sudo npm install -g ember-cli
sudo npm install -g phantomjs

git clone https://github.com/tenzan/ember-todo-ui.git

cd ember-todo-ui

sudo -H -u ubuntu bash -i -c 'npm install'
sudo -H -u ubuntu bash -i -c 'bower install'
sudo -H -u ubuntu bash -i -c 'ember s'
