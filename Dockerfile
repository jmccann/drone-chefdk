FROM ubuntu
MAINTAINER Jacob McCann <jmccann.git@gmail.com>

RUN apt-get update
RUN apt-get install -y curl git apt-transport-https software-properties-common

RUN curl -sSL "https://packagecloud.io/gpg.key" | apt-key add -
RUN apt-add-repository -y "deb https://packagecloud.io/chef/current/ubuntu/ trusty main"
RUN apt-get update
RUN apt-get install -y chefdk
RUN chef gem install chef-sugar

ENV PATH="/opt/chefdk/bin:/root/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
ENV GEM_HOME="/root/.chefdk/gem/ruby/2.1.0"
ENV GEM_PATH="/root/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
