cd subjects/SIP/Kamailio
docker build . -t kamailio
docker build . -t kamailio-snapfuzz -f Dockerfile-snapfuzz
cd -