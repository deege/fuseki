# Apache Jena 
# BUILDAS sudo docker build -t jena .
# RUNAS docker run --name jena -i -t -d -p 3030:3030 jena --mem /data
#

FROM t0nyhays/java8base
MAINTAINER DJ Spiess dj@deege.com

# The version of the Fuseki server
ENV FUSEKI_VERSION 1.1.1

# The version of Jena
ENV JENA_VERSION 2.12.1

ENV FUSEKI_INSTALL_DIR /opt/jena-fuseki


RUN apt-get -y update
RUN apt-get -y install curl

# Install Fuseki server
RUN cd /opt \
&& curl http://www.apache.org/dist/jena/binaries/jena-fuseki-${FUSEKI_VERSION}-distribution.tar.gz \
| tar zx 

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/jena-fuseki-${FUSEKI_VERSION} ${FUSEKI_INSTALL_DIR}

# Install Apache Jena
RUN cd /opt \
&& curl http://www.apache.org/dist/jena/binaries/apache-jena-${JENA_VERSION}.tar.gz \
| tar zx 

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/apache-jena-${JENA_VERSION} /opt/jena

# Make the server runnable
RUN chmod +x ${FUSEKI_INSTALL_DIR}/fuseki-server ${FUSEKI_INSTALL_DIR}/s-*


EXPOSE 3030
# USER fuseki

WORKDIR /opt/jena-fuseki
ENTRYPOINT ["./fuseki-server"] 
CMD ["--help"]
