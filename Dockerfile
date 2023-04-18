FROM python:3.8-slim

RUN apt-get autoremove
RUN apt-get clean

# Install pip, cmake and python
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake && \
    apt-get clean

RUN apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm


RUN git clone https://github.com/HeyImKyu/Alpaca-Turbo alpaca
RUN git clone https://github.com/ViperX7/llama.cpp llama.cpp
RUN cd llama.cpp && make && cd ..

RUN pip install --no-cache-dir -r llama.cpp/requirements.txt

# Install node and build angular
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs
RUN npm install -g @angular/cli

CMD python3 alpaca/api.py
