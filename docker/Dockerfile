## Building
## docker build -t tcnfe --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .
# --------------> The build image
FROM golang:1.14-alpine AS build
ARG ssh_prv_key
ARG ssh_pub_key
RUN apk update && apk add --no-cache build-base make git openssh && rm -rf /var/cache/apk/*
# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
RUN git config --global url."ssh://git@github.com/".insteadOf "https://github.com/" 
WORKDIR /usr/src/app
COPY . /usr/src/app/
RUN env GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ./TCNFe

# --------------> The production image
# --------------> Use only this in Jenkins Pipeline
FROM golang:1.14-alpine
RUN apk add --no-cache --clean-protected \
    bash \
    tzdata \
    curl \
    busybox-extras

RUN  adduser -u 9999 tcuser --disabled-password
USER tcuser
WORKDIR /usr/src/app
COPY --chown=tcuser:tcuser --from=build /usr/src/app/TCNFe /usr/src/app/
COPY --chown=tcuser:tcuser ./config.json /usr/src/app/
EXPOSE 5055/TCP
ENTRYPOINT [ "./TCNFe" ] 