#!/bin/sh

if [ "$USER" != "redbox" ]; then
    echo "Must be run as redbox user"
    exit 1;
fi

RB_SYSTEM=$1
case "$RB_SYSTEM" in
    "redbox")
        echo Deploying ReDBox
        INSTALL_DIR=/opt/redbox
        DEPLOY_DIR=/opt/deploy/redbox
        DEPLOY_URL="http://dev.redboxresearchdata.com.au/nexus/service/local/artifact/maven/redirect?r=snapshots&g=com.googlecode.redbox-mint&a=redbox-local-curation-demo&v=LATEST&c=build&e=tar.gz"
        ;;
    "mint")
        echo Deploying Mint
        INSTALL_DIR=/opt/mint
        DEPLOY_DIR=/opt/deploy/mint
        DEPLOY_URL="http://dev.redboxresearchdata.com.au/nexus/service/local/artifact/maven/redirect?r=snapshots&g=com.googlecode.redbox-mint&a=mint-local-curation-demo&v=LATEST&c=build&e=tar.gz"
        ;;
    *)
        echo Cannot support unknown system: $RB_SYSTEM
        exit 1
        ;;
esac

SERVER_IP=`ifconfig eth0 | awk -F'[: ]+' '/inet addr:/ {print $4}'`
DEPLOY_ARCHIVE=$RB_SYSTEM.tar.gz

echo INSTALL_DIR: $INSTALL_DIR
echo DEPLOY_DIR: $DEPLOY_DIR
echo DEPLOY_URL: $DEPLOY_URL
exit

mkdir $DEPLOY_DIR
cd $DEPLOY_DIR

echo Downloading latest version from Nexus: $DEPLOY_URL
wget  "$DEPLOY_URL" -O $DEPLOY_ARCHIVE
tar xvzf $DEPLOY_ARCHIVE

echo Fixing the incorrect url
sed 's/http:\/\/localhost:9001\/$RB_SYSTEM/http:\/\/$SERVER_IP\/$RB_SYSTEM/g' $RB_SYSTEM/server/tf_env.sh > $RB_SYSTEM/server/tf_env.new
mv $RB_SYSTEM/server/tf_env.new $RB_SYSTEM/server/tf_env.sh

echo Stopping $RB_SYSTEM
$INSTALL_DIR/server/tf.sh stop

cp -rf $RB_SYSTEM/home $INSTALL_DIR/home
cp -rf $RB_SYSTEM/server $INSTALL_DIR/server
cp -rf $RB_SYSTEM/portal $INSTALL_DIR/portal

if [ ! -d "$INSTALL_DIR/solr" ]; then
    cp -rf $RB_SYSTEM/solr $INSTALL_DIR/solr
fi


echo Starting $RB_SYSTEM
$INSTALL_DIR/server/tf.sh start

echo Cleaning up
rm -rf $DEPLOY_DIR
