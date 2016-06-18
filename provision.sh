#Apache
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#firewalld
sudo systemctl start firewalld.service
sudo systemctl enable firewalld.service
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --reload

#MariaDB(標準dbは使わ無い)
sudo yum -y remove mariadb*
sudo rm -rf /var/lib/mysql/

#wget
sudo yum -y install wget

#vim
sudo yum -y install vim

#rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
cat ~/.bash_profile
source $HOME/.bash_profile

#ruby
rbenv install 2.1.3
rbenv global 2.1.3
ruby -v
gem install multi_json -v '1.10.1'
rbenv exec gem install bundler
rbenv rehash
gem install rails --version 4.1.6
source $HOME/.bash_profile


#MySQL
sudo yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo yum -y install mysql-community-server
sudo systemctl enable mysqld.service
sudo systemctl start mysqld.service
# 初期化処理
sudo /usr/bin/mysql_secure_installation

#PHP
sudo yum -y install php php-mysql php-mbstring
sudo systemctl restart httpd.service

# chmod
sudo chmod -R 777 /var/www/html
