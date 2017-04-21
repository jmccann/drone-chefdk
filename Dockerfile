# Docker image for the chefdk plugin
#
#     docker build -t jmccann/drone-chefdk .

FROM chef/chefdk:1.3.48
MAINTAINER Jacob McCann <jmccann.git@gmail.com>

RUN apt-get update && apt-get install -y \
  build-essential \
&& gem install --no-ri --no-rdoc kitchen-openstack -v 3.1.0 \
&& apt-get remove -y build-essential \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
