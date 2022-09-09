cd subjects/TLS/OpenSSL
docker build . -t openssl
docker build . -t openssl-snapfuzz -f Dockerfile-snapfuzz
cd -

./scripts/execution/profuzzbench_exec_common.sh openssl 1 results/openssl aflnet out-openssl-aflnet "-P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none" 600 25 1 0 0

./scripts/execution/profuzzbench_exec_common.sh openssl-snapfuzz 1 results/openssl snapfuzz/aflnet out-openssl-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none" 600 25 1 0 0
