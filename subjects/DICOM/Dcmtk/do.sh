cd subjects/DICOM/Dcmtk/
docker build . -t dcmtk
docker build . -t dcmtk-snapfuzz -f Dockerfile-snapfuzz 

time ./scripts/execution/profuzzbench_exec_common.sh dcmtk 4 results/dcmtk aflnet  out-dcmtk-aflnet "-P DICOM -D 10000 -E -K -m none" 60 50
time ./scripts/execution/profuzzbench_exec_common.sh dcmtk 4 results/dcmtk aflnwe  out-dcmtk-aflnwe "-D 10000 -K -m none" 60 50
time ./scripts/execution/profuzzbench_exec_common.sh dcmtk-snapfuzz 4 results/dcmtk snapfuzz/aflnet  out-dcmtk-snapfuzz "-A /home/ubuntu/snapfuzz/snapfuzz/build/plugins/sbr-afl/libsbr-afl.so -P DICOM -m none" 60 50


cd ../../..