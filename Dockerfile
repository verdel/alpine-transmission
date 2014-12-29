FROM phusion/baseimage

#Install transmission and pushnotify
RUN apt-get -y install software-properties-common && add-apt-repository -y  ppa:transmissionbt/ppa && apt-get update -q
RUN apt-get install -q -y transmission-daemon python-pip && pip install pushnotify
RUN apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*

#Ports
EXPOSE 9091
EXPOSE 51413

#Install init script for transmission
RUN mkdir /etc/service/transmission
ADD transmission.sh /etc/service/transmission/run
RUN chmod +x /etc/service/transmission/run

#Export volumes directory
VOLUME /config/transmission

#Run my_init
CMD ["/sbin/my_init"]
