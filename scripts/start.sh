#!/bin/sh

HOST=$(hostname)

if [[ "$HOST" == "" ]]; then 
	echo "you should set zookeeper quorum."
	exit 1
fi

sed -i -r "s|#HOST#|$HOST|" /etc/hbase/conf/hbase-site.xml 
sed -i -r "s|#HOST#|$HOST|" /etc/hadoop/conf/core-site.xml
sed -i -r "s|#HOST#|$HOST|" /etc/hive/conf/hive-site.xml
sed -i -r "s|#HOST#|$HOST|" /etc/drill/conf/drill-override.conf
sed -i -r "s|#HOST#|$HOST|" /etc/drill/conf/bootstrap-storage-plugins.json

echo "Start hadoop..."
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do 
	service $x start &
done

echo "Start zookeeper"
service zookeeper-server start &

echo "Start master, regionserver a& thrift"
service hbase-master start &
service hbase-regionserver start &
service hbase-thrift start &


echo "Start HIVE"
service mysql start &
service hive-metastore start &
service hive-server2 start &

echo "Start HUE"
service hue start &

echo "Start Impala"
bash -c 'for x in `cd /etc/init.d ; ls impala-*` ; do service $x start ; done'

echo "START DRILL"
/opt/drill/apache-drill-1.1.0/bin/drillbit.sh start

# infinite loop
while :; do sleep 5; done