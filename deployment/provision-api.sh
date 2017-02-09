#!/usr/bin/env bash

sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

sudo apt-get -y update
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libreadline-dev rethinkdb >> /dev/null 2>&1

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"'               >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

sudo -H -u ubuntu bash -i -c 'rbenv install 2.4.0'
sudo -H -u ubuntu bash -i -c 'rbenv global 2.4.0'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'
sudo -H -u ubuntu bash -i -c 'gem install bundler --no-ri --no-rdoc'

sudo -H -u ubuntu bash -i -c 'curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'

#  >> /dev/null 2>&1 is used to avoid messages: dpkg-preconfigure: unable to re-open stdin: No such file or directory
sudo apt-get install -y nodejs >> /dev/null 2>&1

sudo -H -u ubuntu bash -i -c 'gem install --no-ri --no-rdoc rails -v 5.0.1'

cd

git clone https://github.com/tenzan/rails-todo-api.git

sudo -H -u ubuntu bash -i -c 'rethinkdb &'
cd rails-todo-api
sudo -H -u ubuntu bash -i -c 'bundle install'
sudo -H -u ubuntu bash -i -c 'rails nobrainer:seed'
sudo -H -u ubuntu bash -i -c 'rails s -d'
