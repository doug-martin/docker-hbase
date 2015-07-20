## -*- docker-image-name: "doug-martin/docker-hbase" -*-
FROM debian:wheezy
MAINTAINER Doug Martin doug@dougamartin.com

ENV DEBIAN_FRONTEND noninteractive

#Copy over install and setup scripts
COPY scripts /opt/atlas/

# install defaults
RUN ["/bin/bash", "/opt/atlas/install-defaults.sh"]

# install java
RUN ["/bin/bash", "/opt/atlas/install-jdk7.sh"]

ENV JAVA_HOME /usr/java/default

# install cdh5
RUN ["/bin/bash", "/opt/atlas/install-cdh5.sh"]
# install apache drill
RUN ["/bin/bash", "/opt/atlas/install-drill.sh"]
#copy over hive-site since it is needed to setup hive
COPY conf/hive/ /etc/hive/conf/
#Run setup stuffsh
RUN ["/bin/bash", "/opt/atlas/setup.sh"]


# 2181: zookeeper
# 60000: HBase Master API port; 
# 60010 HBase Master Web UI
# 60020: HBase Regionserver API port; 
# 60030 HBase Regionserver web UI; 
# 9090 Hbase Thrift port
# 10000 hive; 
# 8888 hue; 
# 21050 Impala JDBC Port
# 8047: Drill UI
# 31010: Drill Client
EXPOSE 2181 60000 60010 60020 60030 9090 10000 8888 21050 8047 31010

#=======================
# Start services.
#=======================
COPY conf/hbase/ /etc/hbase/conf/
COPY conf/hadoop/ /etc/hadoop/conf/
COPY conf/drill/ /etc/drill/conf/


ENTRYPOINT ["/bin/bash", "/opt/atlas/start.sh"]
CMD []