FROM devopsedu/webapp  
MAINTAINER Dnyaneshwar Kalmode
ADD website /var/www/html

FROM centos:7
RUN yum -y update
RUN yum -y install httpd httpd-tools
# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
# Install PHP
RUN yum --enablerepo=remi-php73 -y install php php-bcmath php-cli php-common php-gd php-intl php-ldap php-mbstring \
    php-mysqlnd php-pear php-soap php-xml php-xmlrpc php-zip
EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
