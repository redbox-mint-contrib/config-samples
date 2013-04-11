Config
* Ensure you add the IP address and hostname to /etc/hosts

Run these:
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 22
sudo ufw enable

sudo adduser --system redbox
sudo mkdir /opt
sudo mkdir /opt/mint /opt/redbox /opt/deploy
sudo chown redbox /opt/*
cd /home/redbox
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/deploy.sh
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/redbox.cron
sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/redbox-mint.sh
sudo chmod u+x deploy.sh
sudo chmod u+x redbox.cron
sudo chmod u+x redbox-mint.sh

sudo apt-get install apache2 maven2
sudo apt-get install denyhosts




Scripts
* redbox.cron - a cron job usually placed in /etc/cron.daily/
* apache - the apache config
* redbox-mint.sh - a /etc/init.d/ script
* deploy.sh - takes 1 param (redbox | mint) and checks to see if there's a new deployment

Other work items you'll need to do once Mint is running:
* Load the GeoNames data: 
* Load the Mint data
