#!/bin/bash

cd /tmp
yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel

wget http://python.org/ftp/python/3.3.2/Python-3.3.2.tar.bz2
tar xf Python-3.3.0.tar.bz2
mv Python-3.3.0 /usr/local/
cd /usr/local/Python-3.3.0
./configure --prefix=/usr/local
make && make install

cd /tmp
wget https://pypi.python.org/packages/source/s/setuptools/setuptools-2.0.tar.gz  --no-check-certificate 
tar -xzf setuptools-2.0.tar.gz  
cd setuptools-2.0
python3 setup.py install

cd /tmp
wget https://pypi.python.org/packages/source/p/pip/pip-1.5.tar.gz  --no-check-certificate 
tar -xzf pip-1.5.tar.gz
cd pip-1.5
python3 setup.py install

pip install virtualenv 
pip install virtualenvwrapper
adduser wwwpub -c 'WWW Content Publisher'
mkdir -p /srv/www/django
chown -R wwwpub:wwwpub /srv/www/django
su - wwwpub
cd /srv/www/django/
mkdir myproj
virtualenv myproj

source myproj/bin/activate
pip install django-cms
pip install django-reversion
pip install gunicorn


gunicorn -w 8 -b 0.0.0.0:8000 myproject.wsgi:application



