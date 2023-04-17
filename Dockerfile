FROM python:3.8-slim

RUN curl -fsSL https://fnm.vercel.app/install | bash && source /root/.bashrc

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip

RUN mkdir -p /app/models

RUN git clone https://github.com/ViperX7/llama.cpp /llama.cpp
RUN cd /llama.cpp && make
RUN mv /llama.cpp/main /main

COPY ./requirements.txt /app/
# COPY ./main /
RUN pip install --no-cache-dir -r /app/requirements.txt

# Install node and build angular
RUN fnm install 18.12.1
RUN npm install -g @angular/cli
RUN cd ui
RUN ng build ../template

# Set the working directory to /app
WORKDIR /app

# Start the webui.py file when the container is started
CMD python3 /app/api.py
