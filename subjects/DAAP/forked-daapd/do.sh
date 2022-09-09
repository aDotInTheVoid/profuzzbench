cd subjects/DAAP/forked-daapd/
docker build . -t forked-daapd
docker build . -t forked-daapd-snapfuzz -f Dockerfile-snapfuzz
cd -

mkdir results/forked-daapd

./scripts/execution/profuzzbench_exec_common.sh forked-daapd          1 results/forked-daapd aflnet          out-forked-daapd-aflnet-4   "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K -t 5000"                                                                       600 25 3 0
./scripts/execution/profuzzbench_exec_common.sh forked-daapd-snapfuzz 1 results/forked-daapd snapfuzz/aflnet out-forked-daapd-snapfuzz-4 "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K -t 5000 -A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so" 600 25 3 3

7200 25 4 0  0
7200 25 4 16 0
