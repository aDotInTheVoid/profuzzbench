mkdir -p results/live555
subjects/RTSP/Live555/build.sh
./scripts/execution/profuzzbench_exec_common.sh live555-snapfuzzz 4 results/live555 snapfuzz/aflnet out-live555-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P RTSP -m none" 3600 5
cd results/live555
source ../../venv/bin/activate
../../scripts/analysis/profuzzbench_plot.py -i results.csv -p live555 -r 4 -c 60 -s 1  -o cov_over_time.png
python3 -m http.server