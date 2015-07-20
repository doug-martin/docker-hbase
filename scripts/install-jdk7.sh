#!/bin/bash

echo "============================="
echo " install jdk7"
echo "============================="

wget -nv --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz && \
	mkdir /opt/jdk && \
	tar -zxf jdk-7u79-linux-x64.tar.gz -C /opt/jdk && \
	mkdir /usr/java && \
	update-alternatives --install /usr/java/default java_default /opt/jdk/jdk1.7.0_79 100 && \
	update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.7.0_79/bin/java 100 && \
	update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.7.0_79/bin/javac 100 && \
	update-alternatives --display java



echo "============================="
echo " set JAVA_HOME"
echo "============================="

echo "#!/bin/bash" >> /etc/profile.d/jdk_home.sh
echo "export JAVA_HOME=/usr/java/default" >> /etc/profile.d/jdk_home.sh
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/jdk_home.sh
source /etc/profile
less /etc/profile.d/jdk_home.sh
echo $JAVA_HOME

java -version 