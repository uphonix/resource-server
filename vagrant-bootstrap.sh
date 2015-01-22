#!/usr/bin/env bash

#
PROJECT_NAME="resource-server"
PERLBREW_ROOT=/opt/perlbrew/perl5
MYSQL_ROOT_PASSWORD="ROOTPASSWORD"
MYSQL_USERNAME="ures"
MYSQL_PASSWORD="mypass"
MYSQL_DBNAME="ures"
PERL_VERSION=5.20.1

# setup perl
export PERLBREW_ROOT

mkdir -p ${PERLBREW_ROOT}

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

sudo apt-get update 2> /dev/null
sudo apt-get install -y make 2> /dev/null
sudo apt-get install -y git emacs23 tree curl openssl 2> /dev/null
sudo apt-get install -y sqlite3 mysql-server 2> /dev/nul
sudo apt-get install -y mysql-client libmysqlclient-dev 2> /dev/null
sudo apt-get install -y nginx 2> /dev/null

## setup mysql
if [ ! -f /var/log/db.setup ];
then
    echo "CREATE USER '${MYSQL_USERNAME}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
    echo "CREATE DATABASE ${MYSQL_DBNAME}" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
    echo "GRANT ALL ON ${MYSQL_DBNAME}.* TO '${MYSQL_USERNAME}'@'localhost'" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
    echo "flush privileges" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}

    touch /var/log/db.setup
fi

# setup perlbrew
sudo apt-get install -y perlbrew
perlbrew init
perlbrew install-cpanm
perlbrew install -n perl-${PERL_VERSION}
chown root:vagrant ${PERLBREW_ROOT} -R
chmod -R g+w ${PERLBREW_ROOT}

# Configure environment
echo "export PERLBREW_ROOT=${PERLBREW_ROOT}" >> /etc/profile.d/perlbrew.sh
echo "export PATH=${PERLBREW_ROOT}/bin:${PERLBREW_ROOT}/perls/perl-${PERL_VERSION}/bin:\$PATH" >> /etc/profile.d/perlbrew.sh

chmod +x /etc/profile.d/perlbrew.sh

cpanm App::Ack --notest

sudo -i -u vagrant <<EOF
    export PERLBREW_ROOT=${PERLBREW_ROOT}
    source /etc/profile.d/perlbrew.sh
    perlbrew use ${PERL_VERSION}
    perlbrew lib create ${PROJECT_NAME} 
    perlbrew use ${PERL_VERSION}@${PROJECT_NAME}

    echo "export PERLBREW_ROOT=${PERLBREW_ROOT}" >> ~/.bashrc
    echo "export PERLBREW_HOME=~/.perlbrew" >> ~/.bashrc
    echo "source ${PERLBREW_ROOT}/etc/bashrc" >> ~/.bashrc
    echo "perlbrew use ${PERL_VERSION}@${PROJECT_NAME}" >> ~/.bashrc

    cd /vagrant && cpanm --notest --installdeps .
EOF

# start servers
