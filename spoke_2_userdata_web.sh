#!/bin/bash
until sudo apt-get update && sudo apt-get -y install apache2; do
    sleep 1
done
sudo mkdir /var/www/html/img
until curl \
    --output /var/www/html/img/pic1.jpg \
    --url https://hol4geocluster.s3.us-east-2.amazonaws.com/img/ninja-02.jpg ; do
    sleep 1
done
sudo chmod a+w /var/www/html/index.html
echo "<html><head></head><body><center><H1>" > /var/www/html/index.html
echo $HOSTNAME >> /var/www/html/index.html
echo "<BR><BR>Spoke VPC 2 - Welcome Cloud Ninja <BR> You just nailed it!<BR>" >> /var/www/html/index.html
echo "<img src=\"img/pic1.jpg\" width=\"50%\" height=\"75%\">" >> /var/www/html/index.html
