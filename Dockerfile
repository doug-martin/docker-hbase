## -*- docker-image-name: "doug-martin/docker-hbase" -*-
FROM debian:wheezy
MAINTAINER Doug Martin doug@dougamartin.com

ENV DEBIAN_FRONTEND noninteractive

# install defaults
COPY install-defaults.sh install-defaults.sh
RUN ["/bin/bash", "install-defaults.sh"]

# install java
COPY install-jdk7.sh install-jdk7.sh
RUN ["/bin/bash", "install-jdk7.sh"]

ENV JAVA_HOME /usr/java/default

# install cdh5
COPY install-cdh5.sh install-cdh5.sh
RUN ["/bin/bash", "install-cdh5.sh"]

COPY install-drill.sh install-drill.sh
RUN ["/bin/bash", "install-drill.sh"]

COPY hive-site.xml /etc/hive/conf/hive-site.xml

#Run setup stuff
COPY setup.sh setup.sh
RUN ["/bin/bash", "setup.sh"]


# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# HBase Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030
# Hbase Thrift port
EXPOSE 9090
# hive
EXPOSE 10000
# hue
EXPOSE 8888
#Impala JDBC Port
EXPOSE 21050
#Drill UI
EXPOSE 8047
#Drill Client
EXPOSE 31010

#=======================
# Start services.
#=======================
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml 
COPY core-site.xml /etc/hadoop/conf/core-site.xml
COPY drill-override.conf /etc/drill/drill-override.conf

COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
CMD []