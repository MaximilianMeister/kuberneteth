FROM node:6

RUN git clone https://github.com/cubedro/eth-netstats
RUN cd /eth-netstats && npm install
RUN cd /eth-netstats && npm install -g grunt-cli
RUN cd /eth-netstats && grunt

RUN git clone https://github.com/cubedro/eth-net-intelligence-api
RUN cd /eth-net-intelligence-api && npm install
RUN cd /eth-net-intelligence-api && npm install -g pm2

ENV PORT 3001

EXPOSE 3001

CMD cd /eth-net-intelligence-api && pm2 start app.json; cd /eth-netstats && npm start
