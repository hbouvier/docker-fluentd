FROM hbouvier/precise-chef
MAINTAINER henri bouvier

RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get -y update
ADD . /chef

RUN cd /chef && /opt/chef/embedded/bin/berks install --path /chef/cookbooks
RUN chef-solo -c /chef/solo.rb -j /chef/solo.json 

EXPOSE 8888

CMD sed "s/ES_PORT_9200_TCP_PORT/$ES_PORT_9200_TCP_PORT/g" /etc/td-agent/elasticsearch.conf.tpl | sed "s/ES_PORT_9200_TCP_ADDR/$ES_PORT_9200_TCP_ADDR/g" > /etc/td-agent/conf.d/elasticsearch.conf && date -u & cat /etc/td-agent/conf.d/elasticsearch.conf && td-agent
