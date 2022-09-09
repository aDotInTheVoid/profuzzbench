cd subjects/FTP/LightFTP
docker build . -t lightftp
docker build . -t lightftp-snapfuzz -f Dockerfile-snapfuzz
cd ../../..

mkdir -p results/lightftp

./scripts/execution/profuzzbench_exec_common.sh lightftp-snapfuzz 4 results/lightftp/ snapfuzz/aflnet out-lightftp-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P FTP -D 10000 -q 3 -s 3 -E -K -m none" 86400 200 4 0  0
./scripts/execution/profuzzbench_exec_common.sh lightftp          4 results/lightftp/ aflnet          out-lightftp-aflnet   "-P FTP -D 10000 -q 3 -s 3 -E -K -m none"                                                                       86400 200 4 16 0
./scripts/execution/profuzzbench_exec_common.sh lightftp          4 results/lightftp/ aflnwe          out-lightftp-aflnwe   "-D 10000 -K -m none"                                                                                           86400 200 4 16 0
./scripts/execution/profuzzbench_exec_common.sh lightftp-stateafl 4 results/lightftp   stateafl       out-lightftp-stateafl "-P FTP -D 10000 -q 3 -s 3 -E -K -m none -u /home/ubuntu/experiments/LightFTP/Source/Release/fftp"              86400 200 4 16 0



source venv/bin/activate
cd results/lightftp
../../scripts/analysis/profuzzbench_generate_csv.sh lightftp 4 snapfuzz results.csv 0
../../scripts/analysis/profuzzbench_generate_csv.sh lightftp 4 aflnet results.csv 1
../../scripts/analysis/profuzzbench_plot.py -i results.csv -p lightftp -r 4 -c 120 -s 1  -o cov_over_time.png
