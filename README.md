# Docker HBASE Container

### Building

```
vagrant ssh
cd ./workspace/docker-hbase
docker build --rm -t hbase .
```

### Running

```
docker run -i -t -d -p 2181:2181 -p 60000:60000 -p 60010:60010 -p 60020:60020 -p 60030:60030 -p 8888:8888 -p 10000:10000 -p 9090:9090 -p 8047:8047 -p 31010:31010 -h c2fo.vagrant hbase
```

### Enter Machine

Using the hash you got when you ran the docker command

```
docker exec -it ${image_hash} bash -l
```