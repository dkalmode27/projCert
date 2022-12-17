FROM devopsedu/webapp
MAINTAINER Dnyaneshwar Kalmode
ADD website /var/www/html
EXPOSE 80
CMD ["/etc/alternatives/php","-D","FOREGROUND"]
