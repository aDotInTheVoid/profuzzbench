cd subjects/SSH/OpenSSH
docker build . -t openssh
docker build . -t openssh-snapfuzz -f Dockerfile-snapfuzz
cd -

mkdir results/openssh

./scripts/execution/profuzzbench_exec_common.sh openssh 1 results/openssh aflnet out-openssh-aflnet "-m none -P SSH -D 10000 -q 3 -s 3 -E -K -W 10" 600 25 1 0 0
./scripts/execution/profuzzbench_exec_common.sh openssh-snapfuzz 1 results/openssh snapfuzz/aflnet out-openssh-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -m none -P SSH -D 10000 -q 3 -s 3 -E -K -W 10" 600 25 1 0 0
