mkdir -p results/live555
subjects/RTSP/Live555/build.sh
./scripts/execution/profuzzbench_exec_common.sh live555-snapfuzzz 4 results/live555 snapfuzz/aflnet out-live555-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P RTSP -m none" 360 5
./scripts/execution/profuzzbench_exec_common.sh live555           4 results/live555 aflnet          out-live555-aflnet   "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none"                                           360 5
./scripts/execution/profuzzbench_exec_common.sh live555           4 results/live555 aflnwe          out-live555-aflnwe   "-D 10000 -K -m none"                                                                   360 5

cd results/live555
source ../../venv/bin/activate

../../scripts/analysis/profuzzbench_generate_csv.sh live555 4 aflnet results.csv 0
../../scripts/analysis/profuzzbench_generate_csv.sh live555 4 aflnwe results.csv 1
../../scripts/analysis/profuzzbench_generate_csv.sh live555 4 snapfuzz results.csv 1

../../scripts/analysis/profuzzbench_plot.py -i results.csv -p live555 -r 4 -c 6 -s 1  -o cov_over_time.png
python3 -m http.server