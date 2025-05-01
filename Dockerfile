ARG NODE_VERSION=lts

# Use the ARM64-compatible Node.js image
FROM arm64v8/node:$NODE_VERSION-alpine

# Set environment variable to disable REPL history
ENV NODE_NO_READLINE=1

RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl bash

RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN adduser --disabled-password --home /home/container container

WORKDIR /home/container

ENV USER=container HOME=/home/container
USER container

COPY ./entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
