FROM php:7.2-apache
MAINTAINER Dnyaneshwar Kalmode
FROM devopsedu/webapp
ADD website /var/www/html
EXPOSE 80
