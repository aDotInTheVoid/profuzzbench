## 1: Build Docker Images

```bash
cd subjects/RTSP/Live555/
docker build . -t live555
docker build . -t live555-snapfuzzz -f Dockerfile-snapfuzz
cd -
```

### Dev Tips:

#### Inspect a stopped container:

Imagine an error like `Error: No such container:path: 6bf27be45ad0:/home/ubuntu/experiments/out-lightftp-aflnet.tar.gz`

We want to see what happened to the now stopped containeer

```bash
docker commit 6bf27be45ad0 inspectme
docker run -it --entrypoint=/bin/bash inspectme
```

#### Inspect a running container:

```bash
docker ps
docker exec -it 537390f81b28 /bin/bash
```

## MAgic

```
ubuntu@87188a058c01:~/experiments/live555/testProgs$ cp ~/snapfuzz/snapfuzz/build/sabre .

strace -s 150 -ff -o ../log3 /home/ubuntu/snapfuzz/aflnet/afl-fuzz -d -i /home/ubuntu/experiments/in-rtsp -x /home/ubuntu/experiments/rtsp.dict -o out-lightftp-snapfuzz -N tcp://127.0.0.1/8554 -A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P RTSP -m none ./testOnDemandRTSPServer 8554
```