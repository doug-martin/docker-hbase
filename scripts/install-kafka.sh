echo "============================="
echo " install Kafka"
echo "============================="

wget -nv https://www.apache.org/dyn/closer.cgi?path=/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz && \
	mkdir /opt/kafka && \
	tar -zxf kafka_2.10-0.8.2.0.tgz -C /opt/kafka && \
	rm kafka_2.10-0.8.2.0.tgz && \
	mkdir /etc/kafka

