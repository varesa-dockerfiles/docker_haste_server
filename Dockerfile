FROM node:0.10.40
MAINTAINER AnthoDingo <lsbdu42@gmail.com>

RUN git clone https://github.com/Janus-SGN/haste-server.git /hastebin

WORKDIR /hastebin

RUN npm install

RUN mkdir data
RUN mv config.js data/
RUN ln -s data/config.js config.js

VOLUME ["/hastebin/data"]

EXPOSE 7777

CMD ["npm", "start"]
