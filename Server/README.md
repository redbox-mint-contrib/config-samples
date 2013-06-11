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
    sudo wget https://raw.github.com/redbox-mint-contrib/config-samples/master/Server/apache
    sudo chmod u+x deploy.sh
    sudo chmod u+x redbox.cron
    sudo chmod u+x redbox-mint.sh
    sudo mv apache /etc/apache2/mods-available/redbox.conf
    sudo chown -R redbox /home/redbox
    
    sudo apt-get install apache2 openjdk-7-jdk
    sudo apt-get install denyhosts htop unzip

    cd /etc/apache2/mods-enabled
    sudo ln -s ../mods-available/proxy_http.load
    sudo ln -s ../mods-available/proxy.conf 
    sudo ln -s ../mods-available/proxy.load
    sudo ln -s ../mods-available/redbox.conf
    sudo apachectl restart

    cd /home/redbox
    sudo ./redbox.cron

    cd /opt/mint/server
    sudo -u redbox ./tf_batch_harvest.sh
    sudo wget http://download.geonames.org/export/dump/allCountries.zip
    sudo unzip allCountries.zip
    sudo -u redbox ./geo_harvest.sh allCountries.txt


Other work items you'll need to do once Mint is running:
* Load the GeoNames data: 
* Load the Mint data

Scripts
* redbox.cron - a cron job usually placed in /etc/cron.daily/
* apache - the apache config
* redbox-mint.sh - a /etc/init.d/ script
* deploy.sh - takes 1 param (redbox | mint) and checks to see if there's a new deployment
