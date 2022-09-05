cd subjects/SMTP/Exim
docker build . -t exim
docker build . -t exim-snapfuzz -f Dockerfile-snapfuzz
cd -