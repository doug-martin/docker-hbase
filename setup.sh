#!/bin/sh

echo "-----------------------------"
echo " Configuration MYSQL"
echo "-----------------------------"
service mysql stop && \
	service mysql start && \
	mysql -e "CREATE USER 'hive'@'localhost' IDENTIFIED BY 'mypassword';" && \
	mysql -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'localhost';" && \
	mysql -e "GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';" && \
	mysql -e "FLUSH PRIVILEGES;" && \
	mysql -e "CREATE DATABASE metastore;" && \
	/usr/lib/hive/bin/schematool -dbType mysql -initSchema
# mysql --verbose metastore < /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-1.1.0.mysql.sql

echo "-----------------------------"
echo " Configuration HDFS"
echo "-----------------------------"
# step1: format
su hdfs -c "hdfs namenode -format"


# step2: start HDFS
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x stop ; done
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done

echo "-----------------------------"
echo " Creating HDFS directories"
echo "-----------------------------"


/usr/lib/hadoop/libexec/init-hdfs.sh
# step3: Verify the HDFS
su - hdfs -c "hadoop fs -ls -R /"


echo "-----------------------------"
echo "Setup Zookeeper"
echo "-----------------------------"
service zookeeper-server init --myid=1


echo "-----------------------------"
echo "Cleanup"
echo "-----------------------------"
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x stop ; done
service zookeeper-server stop
service hbase-master stop
service hbase-regionserver stop
service hbase-thrift stop
service hive-metastore stop
service hive-server2 stop
service hue stop