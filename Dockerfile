FROM python:3.8-slim


RUN apt-get autoremove
RUN apt-get clean

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm

RUN mkdir -p /workspaces/Alpaca-Turbo/models

RUN git clone https://github.com/ViperX7/llama.cpp /workspaces/Alpaca-Turbo/llama.cpp
RUN cd /workspaces/Alpaca-Turbo/llama.cpp && make
# RUN mv ./main /workspaces/Alpaca-Turbo/main

RUN ls /workspaces
RUN ls /workspaces/Alpaca-Turbo

COPY ./requirements.txt /workspaces
# COPY ./main /
RUN pip install --no-cache-dir -r /workspaces/requirements.txt

# Install node and build angular
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs
RUN npm install -g @angular/cli

RUN ls .
RUN ls /

CMD python3 ./api.py
