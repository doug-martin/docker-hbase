#!/bin/bash

echo "============================="
echo " install CDH5"
echo "============================="
#Add CDH5 repo
wget 'http://archive.cloudera.com/cdh5/debian/wheezy/amd64/cdh/cloudera.list' -O /etc/apt/sources.list.d/cloudera.list  
wget http://archive.cloudera.com/cdh5/debian/wheezy/amd64/cdh/archive.key -O archive.key
apt-key add archive.key
apt-get update

# install hbase    
apt-get -y install hadoop-conf-pseudo hbase hbase-master hbase-regionserver hbase-thrift hive hive-metastore hive-server2 hive-hbase impala impala-server impala-state-store impala-catalog impala-shell zookeeper zookeeper-server mysql-server libmysql-java hue && \
	ls -la /usr/share/java/ && \
	update-alternatives --install /usr/lib/hive/lib/libmysql-java.jar hive_mysql_connector /usr/share/java/mysql.jar 100 && \
	chkconfig mysql on
