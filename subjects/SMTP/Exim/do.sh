cd subjects/SMTP/Exim
docker build . -t exim
docker build . -t exim-snapfuzz -f Dockerfile-snapfuzz
cd -

mkdir -p results/exim

./scripts/execution/profuzzbench_exec_common.sh exim 1 results/exim aflnet out-exim-aflnet "-P SMTP -D 10000 -q 3 -s 3 -E -K -W 100" 600 25 1 0 0
./scripts/execution/profuzzbench_exec_common.sh exim-snapfuzz 1 results/exim snapfuzz/aflnet out-exim-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P SMTP -D 10000 -q 3 -s 3 -E -K -W 100" 600 25 1 0 0