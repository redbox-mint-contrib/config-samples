#!/bin/sh
sudo rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
sudo yum install puppet
sudo puppet module install puppetlabs/apache
sudo puppet apply site.pp
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/deploy.sh  -o /home/redbox/deploy.sh
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/redbox.cron  -o /home/redbox/redbox.cron
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/redbox-mint.sh   -o /home/redbox/redbox-mint.sh 
sudo chmod +x /home/redbox/deploy.sh
sudo chmod +x /home/redbox/redbox.cron
sudo chmod +x /home/redbox/redbox-mint.sh
sudo /home/redbox/redbox.cron