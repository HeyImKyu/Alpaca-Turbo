FROM python:3.8-slim


RUN apt-get autoremove
RUN apt-get clean

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm

WORKDIR /workspaces/Alpaca-Turbo

RUN mkdir -p /workspaces/Alpaca-Turbo/models

RUN git clone https://github.com/ViperX7/llama.cpp /workspaces/Alpaca-Turbo/llama.cpp
RUN cd /workspaces/Alpaca-Turbo/llama.cpp && make
# RUN mv ./main /workspaces/Alpaca-Turbo/main

#COPY ./requirements.txt /app/
# COPY ./main /
RUN pip install --no-cache-dir -r /workspaces/Alpaca-Turbo/requirements.txt

# Install node and build angular
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs
RUN npm install -g @angular/cli

WORKDIR /workspaces/Alpaca-Turbo/ui
RUN npm install
RUN ng build --output-path /workspaces/Alpaca-Turbo/template

# Set the working directory to /app
WORKDIR /workspaces/Alpaca-Turbo

# Start the webui.py file when the container is started
CMD python3 /workspaces/Alpaca-Turbo/api.py
