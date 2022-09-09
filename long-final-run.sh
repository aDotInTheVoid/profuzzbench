#!/bin/bash
deactivate
source venv/bin/activate
set -eou pipefail

RES_DIR="results-long"
REPS=4
NCPU=4
RUNTIME=28800 # 8 hours
TIMEOUT=5000
SAMPLE=50

# # # # # # # # # # # # # # # #
# Part 1: Build Docker Images #
# # # # # # # # # # # # # # # #

cd subjects/DNS/Dnsmasq/
docker build . -t dnsmasq
docker build . -t dnsmasq-snapfuzz -f Dockerfile-snapfuzz
docker build . -t dnsmasq-stateafl -f Dockerfile-stateafl
cd -

cd subjects/FTP/LightFTP/
docker build . -t lightftp
docker build . -t lightftp-snapfuzz -f Dockerfile-snapfuzz
docker build . -t lightftp-stateafl -f Dockerfile-stateafl
cd -

cd subjects/RTSP/Live555/
docker build . -t live555
docker build . -t live555-snapfuzz -f Dockerfile-snapfuzz
docker build . -t live555-stateafl -f Dockerfile-stateafl
cd -

cd subjects/DTLS/TinyDTLS
docker build . -t tinydtls
docker build . -t tinydtls-snapfuzz -f Dockerfile-snapfuzz
docker build . -t tinydtls-stateafl -f Dockerfile-stateafl
cd -

# if [[ -d $RES_DIR ]]; then
#     echo $RES_DIR exits
#     exit 1
# fi

# mkdir $RES_DIR
# mkdir $RES_DIR/dnsmasq
# mkdir $RES_DIR/lightftp
# mkdir $RES_DIR/live555
# mkdir $RES_DIR/tinydtls

EXEC=./scripts/execution/profuzzbench_exec_common.sh

echo $EXEC dnsmasq          $REPS $RES_DIR/dnsmasq aflnet          out-dnsmasq-aflnet   \"-P DNS -D 10000 -K -R -q 3 -s 3 -m none -t ${TIMEOUT}\"                                                                       $RUNTIME $SAMPLE $NCPU 0  0
echo $EXEC dnsmasq-snapfuzz $REPS $RES_DIR/dnsmasq snapfuzz/aflnet out-dnsmasq-snapfuzz \"-P DNS -D 10000 -K -R -q 3 -s 3 -m none -t ${TIMEOUT} -A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so\" $RUNTIME $SAMPLE $NCPU 16 0


echo $EXEC lightftp-snapfuzz $REPS $RES_DIR/lightftp snapfuzz/aflnet out-lightftp-snapfuzz \"-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P FTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TIMEOUT}\" $RUNTIME $SAMPLE $NCPU 0  0
echo $EXEC lightftp          $REPS $RES_DIR/lightftp aflnet          out-lightftp-aflnet   \"-P FTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TIMEOUT}\"                                                                       $RUNTIME $SAMPLE $NCPU 16 0
# echo $EXEC lightftp          $REPS $RES_DIR/lightftp aflnwe          out-lightftp-aflnwe   \"-D 10000 -K -m none\"                                                                                           #86400 200 4 16 0
# echo $EXEC lightftp-stateafl $REPS $RES_DIR/lightftp stateafl        out-lightftp-stateafl \"-P FTP -D 10000 -q 3 -s 3 -E -K -m none -u /home/ubuntu/experiments/LightFTP/Source/Release/fftp\"              $86400 200 4 16 0


# Using a timeout kills performance
echo $EXEC live555-snapfuzz $REPS $RES_DIR/live555 snapfuzz/aflnet out-live555-snapfuzz \"-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none  -A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so\" $RUNTIME $SAMPLE $NCPU 0  0
echo $EXEC live555          $REPS $RES_DIR/live555 aflnet          out-live555-aflnet   \"-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none \"                                                                       $RUNTIME $SAMPLE $NCPU 16 0

echo $EXEC tinydtls-snapfuzz $REPS $RES_DIR/tinydtls snapfuzz/aflnet out-tinydtls-snapfuzz \"-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none -t ${TIMEOUT}\" $RUNTIME $SAMPLE $NCPU 0  0
echo $EXEC tinydtls          $REPS $RES_DIR/tinydtls          aflnet out-tinydtls-aflnet   \"-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none -t ${TIMEOUT}\"                                                                       $RUNTIME $SAMPLE $NCPU 16 0

