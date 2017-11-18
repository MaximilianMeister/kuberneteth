FROM node:6

RUN git clone https://github.com/cubedro/eth-net-intelligence-api
RUN cd /eth-net-intelligence-api && npm install
RUN cd /eth-net-intelligence-api && npm install -g pm2

CMD cd /eth-net-intelligence-api && pm2 --no-daemon start app.json
