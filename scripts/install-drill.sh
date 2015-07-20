echo "============================="
echo " install Drill"
echo "============================="

wget -nv http://getdrill.org/drill/download/apache-drill-1.1.0.tar.gz && \
	mkdir /opt/drill && \
	tar -zxf apache-drill-1.1.0.tar.gz -C /opt/drill && \
	mkdir /etc/drill
