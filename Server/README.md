* redbox.cron - a cron job usually placed in /etc/cron.daily/
* apache - the apache config
* redbox-mint.sh - a /etc/init.d/ script
* deploy.sh - takes 1 param (redbox | mint) and checks to see if there's a new deployment

Other work items you'll need to do:
* Create the 'redbox' user
* Create /opt/redbox /opt/mint & /opt/deploy and chown to 'redbox'
* Load the GeoNames data: /opt/mint/home/logs/geo_harvest.out
