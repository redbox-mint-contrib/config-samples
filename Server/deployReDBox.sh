#!/bin/sh
#tar zcvf /home/brazzaa/backups/redboxBackup$(date '+%F_%H%I%S%P').tar.gz /opt/redbox/

cd /opt/deploy

wget  "http://dev.redboxresearchdata.com.au/nexus/service/local/artifact/maven/redirect?r=snapshots&g=com.googlecode.redbox-mint&a=redbox-local-curation-demo&v=LATEST&c=build&e=tar.gz" -O redbox.tar.gz
/opt/redbox/server/tf.sh stop

tar xvfz redbox.tar.gz

sed 's/http:\/\/localhost:9000\/redbox/http:\/\/dev.redboxresearchdata.com.au\/ci-redbox/g' redbox/server/tf_env.sh > redbox/server/tf_env.new
mv redbox/server/tf_env.new redbox/server/tf_env.sh

sed 's/\/mint/\/ci-mint/g' redbox/server/tf_env.sh > redbox/server/tf_env.new
mv redbox/server/tf_env.new redbox/server/tf_env.sh

sed 's/redbox/ci-redbox/g' redbox/server/jetty/contexts/fascinator.xml > redbox/server/jetty/contexts/fascinator.new
mv redbox/server/jetty/contexts/fascinator.new redbox/server/jetty/contexts/fascinator.xml

sed 's/http:\/\/localhost:9000\/redbox/http:\/\/dev.redboxresearchdata.com.au\/ci-redbox/g' redbox/home/system-config.json > redbox/home/system-config.new
mv redbox/home/system-config.new redbox/home/system-config.json


cp -rf redbox/* /opt/redbox/

/opt/redbox/server/tf.sh start

rm redbox.tar.gz
rm -rf redbox/