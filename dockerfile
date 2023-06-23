FROM alpine
ENV GOPATH /usr/local/go
ENV REPO $GOPATH/pixlet
ENV PATH "${PATH}:${GOPATH}/bin:${REPO}"
ENV APP /app

#install prereqs
RUN apk update && \
    apk upgrade -U && \
    apk add curl wget git openssh-client make libc-dev gcc ca-certificates npm libwebp-dev libwebp-tools patchelf gcompat && \
    rm -rf /var/cache/*
RUN wget "https://go.dev/dl/$(curl 'https://go.dev/VERSION?m=text').linux-amd64.tar.gz" && tar -C /usr/local -xzf go*.linux-amd64.tar.gz && rm -f go*.linux-amd64.tar.gz
RUN patchelf --set-interpreter /lib/libc.musl-x86_64.so.1 /usr/local/go/bin/go

#Download Pixlet
RUN git clone https://github.com/tidbyt/pixlet.git $REPO 
WORKDIR $REPO

#Build Pixlet
RUN npm install && npm run build
RUN make build

RUN git clone --recurse-submodules https://github.com/theterg/pixlet-docker-community.git $APP

#clean up build prereqs
RUN apk del -r curl wget make gcc patchelf libc-dev 

RUN mkdir -p /root/.config/tidbyt/
COPY private.yaml /root/.config/tidbyt/private.yaml

RUN rm /etc/crontabs/root
RUN ln -s /app/crontab /etc/crontabs/root

EXPOSE 8080
