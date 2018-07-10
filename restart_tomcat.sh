#!/usr/bin/env bash
WAR=tc2
TOMCAT_ROOT=~joconnor/Java/apache-tomcat-8.5.32
#export JAVA_OPTS="-Xcompile.invokedynamics=true -Djruby.objectspace.enabled=false"
export JAVA_OPTS="-XX:+PrintGCDetails -Xms512m -Xmx1024m"
echo "Shutting down Tomcat"
$TOMCAT_ROOT/bin/shutdown.sh
echo "Deleting $WAR from $TOMCAT_ROOT/webapps"
rm -fr $TOMCAT_ROOT/webapps/$WAR
echo "copying $WAR.war to $TOMCAT_ROOT/webapps"
cp $WAR.war $TOMCAT_ROOT/webapps
echo "starting tomcat"
$TOMCAT_ROOT/bin/startup.sh
ps -elf | grep catalina
