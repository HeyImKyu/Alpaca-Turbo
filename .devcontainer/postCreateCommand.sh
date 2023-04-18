apt-get autoremove
apt-get clean

apt-get update && apt-get install -y --no-install-recommends cmake && apt-get clean

apt-get install -y --no-install-recommends curl wget vim git gcc make libc6-dev g++ unzip nodejs npm

mkdir -p /workspaces/Alpaca-Turbo/models

git clone https://github.com/ViperX7/llama.cpp /workspaces/Alpaca-Turbo/llama.cpp
cd /workspaces/Alpaca-Turbo/llama.cpp && make

mv ./requirements.txt /workspaces
pip install --no-cache-dir -r /workspaces/requirements.txt

# Install node and build angular
curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && apt-get install -y nodejs
npm install -g @angular/cli

ls /workspaces
ls /workspaces/Alpaca-Turbo

cd /workspaces/Alpaca-Turbo/ui
npm install
ng build --output-path /workspaces/Alpaca-Turbo/template
