FROM node:6

RUN git clone https://github.com/cubedro/eth-netstats
RUN cd /eth-netstats && npm install
RUN cd /eth-netstats && npm install -g grunt-cli
RUN cd /eth-netstats && grunt

ENV PORT 3001

EXPOSE 3001

CMD cd /eth-netstats && npm start
