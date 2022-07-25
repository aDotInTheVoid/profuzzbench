docker build . -t tinydtls
docker build . -t tinydtls-snapfuzz -f Dockerfile-snapfuzz
cd ../../..

mkdir -p results/tinydtls/

./scripts/execution/profuzzbench_exec_common.sh tinydtls-snapfuzz 2 results/tinydtls snapfuzz/aflnet out-tinydtls-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none" 3600 50
./scripts/execution/profuzzbench_exec_common.sh tinydtls          2 results/tinydtls          aflnet out-tinydtls-aflnet   "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none" 3600 50 
./scripts/execution/profuzzbench_exec_common.sh tinydtls          2 results/tinydtls          aflnwe out-tinydtls-aflnwe   "-D 10000 -K -W 30 -m none" 3600 50

source venv/bin/activate
cd results/tinydtls

../../scripts/analysis/profuzzbench_generate_csv.sh tinydtls 2 aflnet results.csv 0
../../scripts/analysis/profuzzbench_generate_csv.sh tinydtls 2 aflnwe results.csv 1
../../scripts/analysis/profuzzbench_generate_csv.sh tinydtls 2 snapfuzz results.csv 1

../../scripts/analysis/profuzzbench_plot.py -i results.csv -p tinydtls -r 2 -c 60 -s 1  -o cov_over_time.png
python3 -m http.server
