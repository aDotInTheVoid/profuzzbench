cd subjects/DNS/Dnsmasq
docker build . -t dnsmasq
docker build . -t dnsmasq-snapfuzz -f Dockerfile-snapfuzz
cd -

# For snapfuzz, we don't use `-E` for some reason

mkdir results/dnsmasq
./scripts/execution/profuzzbench_exec_common.sh dnsmasq          4 results/dnsmasq aflnet          out-dnsmasq-aflnet   "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none -t 5000"                                                                       7200 25 4 0  0
./scripts/execution/profuzzbench_exec_common.sh dnsmasq-snapfuzz 4 results/dnsmasq snapfuzz/aflnet out-dnsmasq-snapfuzz "-P DNS -D 10000 -K -R -q 3 -s 3    -m none -t 5000 -A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so" 7200 25 4 16 0

source venv/bin/activate
cd results/dnsmasq/

../../scripts/analysis/profuzzbench_generate_csv.sh dnsmasq 4 snapfuzz results.csv 0
../../scripts/analysis/profuzzbench_generate_csv.sh dnsmasq 4 aflnet   results.csv 1

../../scripts/analysis/profuzzbench_plot.py -i results.csv -p dnsmasq -r 4 -c 120 -s 1  -o cov_over_time.png
