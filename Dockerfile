FROM python:3.8-slim


RUN apt-get autoremove
RUN apt-get clean

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm


RUN mkdir -p /app/models

RUN git clone https://github.com/ViperX7/llama.cpp /llama.cpp
RUN cd /llama.cpp && make
RUN mv /llama.cpp/main /main

COPY ./requirements.txt /app/
# COPY ./main /
RUN pip install --no-cache-dir -r /app/requirements.txt

RUN ls /
RUN ls /app
RUN ls /app/ui

# Install node and build angular
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs
RUN npm install -g @angular/cli

WORKDIR /app/ui
RUN npm install
RUN ng build --output-path ./template
RUN mv ./template /app/template

# Set the working directory to /app
WORKDIR /app

# Start the webui.py file when the container is started
CMD python3 /app/api.py
