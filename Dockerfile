FROM python:3.8-slim

RUN apt-get autoremove
RUN apt-get clean

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm


RUN git clone https://github.com/HeyImKyu/Alpaca-Turbo /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo
RUN mkdir -p /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/models

RUN git clone https://github.com/ViperX7/llama.cpp /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/llama.cpp
RUN cd /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/llama.cpp && make
# RUN mv ./main /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/main

RUN ls /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo
RUN ls /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/llama.cpp

COPY ./requirements.txt /workspaces
# COPY ./main /
RUN pip install --no-cache-dir -r /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/llama.cpp/requirements.txt

# Install node and build angular
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs
RUN npm install -g @angular/cli

CMD python3 /var/lib/docker/codespacemount/workspaces/Alpaca-Turbo/api.py
