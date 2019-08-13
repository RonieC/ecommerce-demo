FROM node:alpine

RUN npm install --global gulp
#Install common tools
RUN apk add --update --no-cache \
    curl \
    git \
    groff \
    less \
    openssh-client \
    jq \
    bc \
    gettext \
    zip \
    tar \
    bash && \
    rm -rf /var/cache/apk/*

CMD /bin/sh
