# Docker image for the chefdk plugin
#
#     docker build --rm=true -t jmccann/drone-chefdk .

FROM ubuntu
MAINTAINER Jacob McCann <jmccann.git@gmail.com>

RUN apt-get update
RUN apt-get install -y curl git apt-transport-https software-properties-common

RUN curl -sSL "https://downloads.chef.io/packages-chef-io-public.key" | apt-key add -
RUN apt-add-repository -y "deb https://packages.chef.io/stable-apt trusty main"
RUN apt-get update && apt-get install -y \
  chefdk=0.16.28-1 \
  docker.io \
  build-essential \
&& /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-docker -v 2.4.0 \
&& /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-openstack -v 3.0.0 \
&& apt-get remove -y build-essential \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# RUN /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-docker -v 2.4.0
# RUN /opt/chefdk/bin/chef gem install --no-ri --no-rdoc kitchen-openstack -v 3.0.0

RUN locale-gen en_US.UTF-8

# Set ChefDK paths
ENV PATH="/opt/chefdk/bin:/root/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
ENV GEM_HOME="/root/.chefdk/gem/ruby/2.1.0"
ENV GEM_PATH="/root/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"

# Set locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
