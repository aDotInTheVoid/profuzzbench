cd subjects/SIP/Kamailio
docker build . -t kamailio
docker build . -t kamailio-snapfuzz -f Dockerfile-snapfuzz
cd -

mkdir results/kamailio

./scripts/execution/profuzzbench_exec_common.sh kamailio 1 results/kamailio aflnet out-kamailio-aflnet "-m none -t 3000+ -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K" 600 5 1 0 0

./scripts/execution/profuzzbench_exec_common.sh kamailio-snapfuzz 1 results/kamailio snapfuzz/aflnet out-kamailio-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -m none -t 10000 -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K" 600 5 1 0 0