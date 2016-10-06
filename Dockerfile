# Docker image for the chefdk plugin
#
#     docker build --rm=true -t jmccann/drone-chefdk .

FROM ubuntu:16.04
MAINTAINER Jacob McCann <jmccann.git@gmail.com>

RUN apt-get update && \
    apt-get install -y curl git apt-transport-https software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://downloads.chef.io/packages-chef-io-public.key" | apt-key add -
RUN apt-add-repository -y "deb https://packages.chef.io/stable-apt trusty main"
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y \
  chefdk=0.18.26-1 \
  docker-engine=1.11.2-0~xenial \
  build-essential \
&& /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-docker -v 2.6.0 \
&& /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-openstack -v 3.1.0 \
&& apt-get remove -y build-essential \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

# Set ChefDK paths
ENV PATH="/opt/chefdk/bin:/root/.chefdk/gem/ruby/2.3.0/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chefdk/gitbin"
ENV GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.3.0"
ENV GEM_HOME="/root/.chefdk/gem/ruby/2.3.0"
ENV GEM_PATH="/root/.chefdk/gem/ruby/2.3.0:/opt/chefdk/embedded/lib/ruby/gems/2.3.0"

# Set locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
