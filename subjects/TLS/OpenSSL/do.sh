cd subjects/TLS/OpenSSL
docker build . -t openssl
docker build . -t openssl-snapfuzz -f Dockerfile-snapfuzz
cd -