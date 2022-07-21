docker build . -t lightftp
docker build . -t lightftp-snapfuzz -f Dockerfile-snapfuzz
cd ../../..
mkdir -p results/lightftp

./scripts/execution/profuzzbench_exec_common.sh lightftp 1 results/lightftp/ aflnet out-lightftp-aflnet "-P FTP -D 10000 -q 3 -s 3 -E -K -m none" 3600 50
./scripts/execution/profuzzbench_exec_common.sh lightftp 1 results/lightftp/ aflnwe out-lightftp-aflnwe "-D 10000 -K -m none" 3600 50
./scripts/execution/profuzzbench_exec_common.sh lightftp-snapfuzz 1 results/lightftp/ snapfuzz/aflnet out-lightftp-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P FTP -m none" 3600 50
