FROM bucharestgold/centos7-s2i-nodejs:10.x
MAINTAINER AnthoDingo <lsbdu42@gmail.com>

USER root

# Fix for openshift parent image missing libcurl
RUN yum install -y libcurl && yum clean all


RUN LD_LIBRARY_PATH=/opt/rh/httpd24/root/usr/lib64/ git clone https://github.com/seejohnrun/haste-server.git /hastebin

WORKDIR /hastebin

RUN npm install

RUN mkdir data
RUN mv config.js data/
RUN ln -s data/config.js config.js

# For OpenShift
RUN chgrp 0 /hastebin -R
RUN chmod g+rwX /hastebin -R
USER 1001

VOLUME ["/hastebin/data"]

EXPOSE 7777

CMD ["npm", "start"]
