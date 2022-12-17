FROM devopsedu/webapp  
MAINTAINER Dnyaneshwar Kalmode
RUN yum -y update
ADD website /var/www/html
EXPOSE 80
