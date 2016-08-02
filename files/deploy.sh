#!/bin/bash

KOMEA_LOCATION="/opt/echoes/dashboard"
NEXUS_URL=$1
NEXUS_LOGIN=$2
NEXUS_PASSWORD=$3
NEXUS_REPOSITORY=$4
VERSION=$5
NEXUS_THIRD_PARTIES_REPO=$6
ACTIVEMQ_VERSION=$7
SECURITY_VERSION=$8

APP_TIMESERIES_PATH="$KOMEA_LOCATION/application-timeseries"
APP_ORGANIZATION_PATH="$KOMEA_LOCATION/application-organization"
APP_METRICS_PATH="$KOMEA_LOCATION/application-metrics"
APP_CHARTS_PATH="$KOMEA_LOCATION/application-charts"
ADMIN_GUI_PATH="$KOMEA_LOCATION/admin-gui"
ADMIN_SERVER_PATH="$KOMEA_LOCATION/admin-server"

KOMEA_GROUP_ID="org/komea/dashboard"
SECURITY_GROUP_ID="org/komea/security"
APACHE_GROUP_ID="org/apache"

retrieveFromNexus() {
  OUTPUT=$1
  REPO=$2
  GROUP_ID=$3
  ARTIFACT=$4
  ARTIFACT_VERSION=$5
  EXTENSION=$6

  curl -X GET -u $NEXUS_LOGIN:$NEXUS_PASSWORD -o "$OUTPUT.md5" "$NEXUS_URL/content/repositories/$REPO/$GROUP_ID/$ARTIFACT/$ARTIFACT_VERSION/$ARTIFACT-$ARTIFACT_VERSION.$EXTENSION.md5"
  OUTPUT_MD5=`md5sum $OUTPUT | awk '{ print $1 }'`
  REMOTE_MD5=`cat $OUTPUT.md5`

  if [ "$OUTPUT_MD5" =  "$REMOTE_MD5" ]
  then
    echo "$OUTPUT is already the latest version!"
  else
    echo "$OUTPUT_MD5 != $REMOTE_MD5"
    curl -X GET -u $NEXUS_LOGIN:$NEXUS_PASSWORD -o $OUTPUT  "$NEXUS_URL/content/repositories/$NEXUS_REPOSITORY/$GROUP_ID/$ARTIFACT/$ARTIFACT_VERSION/$ARTIFACT-$ARTIFACT_VERSION.$EXTENSION"
  fi
}

# Deploy Sprint-Boot Jars
retrieveFromNexus "$APP_TIMESERIES_PATH/application-timeseries.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "application-timeseries" $VERSION "jar"
retrieveFromNexus "$APP_ORGANIZATION_PATH/application-organization.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "application-organization" $VERSION "jar"
retrieveFromNexus "$APP_METRICS_PATH/application-metrics.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "application-metrics" $VERSION "jar"
retrieveFromNexus "$APP_CHARTS_PATH/application-charts.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "application-charts" $VERSION "jar"
retrieveFromNexus "$ADMIN_GUI_PATH/admin-gui.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "gui-organization" $VERSION "jar"
retrieveFromNexus "$ADMIN_SERVER_PATH/admin-server.jar" $NEXUS_REPOSITORY $KOMEA_GROUP_ID "admin-server" $VERSION "jar"

# Deploy ActiveMQ
ACTIVEMQ_ZIP="$KOMEA_LOCATION/apache-activemq.zip"
BEFORE_MD5=`md5sum $ACTIVEMQ_ZIP | awk '{ print $1 }'`
retrieveFromNexus $ACTIVEMQ_ZIP $NEXUS_THIRD_PARTIES_REPO $APACHE_GROUP_ID "activemq" $ACTIVEMQ_VERSION "zip"
AFTER_MD5=`md5sum $ACTIVEMQ_ZIP | awk '{ print $1 }'`
if [ "$BEFORE_MD5" =  "$AFTER_MD5" ]
then
  echo "$ACTIVEMQ_ZIP has not changed."
else
  unzip -o $ACTIVEMQ_ZIP -d $KOMEA_LOCATION
fi

# Deploy ActiveMQ Security Plugin
retrieveFromNexus "$KOMEA_LOCATION/apache-activemq-$VERSION/lib/komea-activemq-plugin.jar" $NEXUS_REPOSITORY $SECURITY_GROUP_ID "komea-activemq-plugin" $SECURITY_VERSION
