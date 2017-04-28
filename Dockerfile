FROM ubuntu:16.10

MAINTAINER Brian Ping <Brianping7@gmail.com>

##################################################
# Set environment variables                      #
##################################################

ENV LANG C.UTF-8

##################################################
# Install tools                                  #
##################################################

RUN alias ll='ls -alG'

RUN apt-get update
RUN apt-get install -y curl apt-utils apt-transport-https locales
RUN apt-get install -y --no-install-recommends python build-essential make g++ libavahi-compat-libdnssd-dev net-tools
RUN apt-get install -y --no-install-recommends libffi-dev libssl-dev

##################################################
# Install Python3 and NodeJS                     #
##################################################

#RUN apt-get install -y --no-install-recommends python3-dev python3-pip && pip3 install -U setuptools
#RUN pip3 install construct click cryptography pretty_cron

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y --no-install-recommends nodejs

#RUN npm install -g node-uuid request tough-cookie-filestore wake_on_lan appdirectory minimist debug mkdirp express


##################################################
# Clean the image                                #
##################################################
# Remove apt cache to make the image smaller

#RUN npm cache clean
RUN apt-get remove -y curl
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

##################################################
# Start                                          #
##################################################

USER root

ADD jarvis-run /root/jarvis-run

EXPOSE 7007 55677
CMD ["/root/jarvis-run"]