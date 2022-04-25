FROM ubuntu:20.04


RUN addgroup --gid 101 energi && \
    adduser --uid 101 energi --ingroup energi --disabled-password && \
    apt-get update && \
    apt-get install wget curl -y && \
    wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.2/energi3-v3.1.2-linux-amd64.tgz && \
    wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.2/SHA256SUMS && \
    sha256sum -c --ignore-missing SHA256SUMS && \ 
    tar -zxvf energi3-v3.1.2-linux-amd64.tgz && \
    mv energi3-v3.1.2-linux-amd64/bin/energi3 /usr/local/bin/ && \
    curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/install.sh | sh -s -- -b /usr/local/bin && \
    trivy filesystem  --no-progress /

USER energi

CMD ["energi3"]
