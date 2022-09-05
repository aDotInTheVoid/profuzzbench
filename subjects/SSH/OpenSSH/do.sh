cd subjects/SSH/OpenSSH
docker build . -t openssh
docker build . -t openssh-snapfuzz -f Dockerfile-snapfuzz
cd -