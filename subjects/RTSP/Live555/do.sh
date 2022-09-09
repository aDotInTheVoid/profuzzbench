
cd subjects/RTSP/Live555/

docker build . -t live555
docker build . -t live555-snapfuzz -f Dockerfile-snapfuzz
cd -

mkdir -p results/live555

./scripts/execution/profuzzbench_exec_common.sh live555-snapfuzz 4 results/live555 snapfuzz/aflnet out-live555-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none" 7200 25 4 0  0
./scripts/execution/profuzzbench_exec_common.sh live555          4 results/live555 aflnet          out-live555-aflnet   "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none"                                                                       7200 25 4 16 0

source venv/bin/activate
cd results/live555

../../scripts/analysis/profuzzbench_generate_csv.sh live555 4 aflnet-4 results.csv 0
../../scripts/analysis/profuzzbench_generate_csv.sh live555 4 snapfuzz-4 results.csv 1

../../scripts/analysis/profuzzbench_plot.py -i results.csv -p live555 -r 4 -c 5 -s 1  -o cov_over_time.png
