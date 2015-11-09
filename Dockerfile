# Docker image for the chefdk plugin
#
#     docker build --rm=true -t jmccann/drone-chefdk .

FROM ubuntu
MAINTAINER Jacob McCann <jmccann.git@gmail.com>

RUN apt-get update
RUN apt-get install -y curl git apt-transport-https software-properties-common

RUN curl -sSL "https://packagecloud.io/gpg.key" | apt-key add -
RUN apt-add-repository -y "deb https://packagecloud.io/chef/stable/ubuntu/ trusty main"
RUN apt-get update
RUN apt-get install -y chefdk=0.10.0-1
RUN chef gem install chef-sugar

RUN locale-gen en_US.UTF-8

# Set ChefDK paths
ENV PATH="/opt/chefdk/bin:/root/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
ENV GEM_HOME="/root/.chefdk/gem/ruby/2.1.0"
ENV GEM_PATH="/root/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"

# Set locale
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
