FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
    cowsay \
    fortune \
    netcat-openbsd \
    bash

WORKDIR /app

COPY . .

RUN chmod +x wisecow.sh

EXPOSE 4499

CMD ["bash", "wisecow.sh"]