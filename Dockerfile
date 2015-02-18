FROM debian
MAINTAINER Thiago Veronezi

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git
RUN apt-get install -y tar
RUN apt-get install -y openjdk-7-jdk

RUN mkdir -p /opt/tomee/
RUN cd /opt/tomee/ && wget http://apache.parentingamerica.com/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
RUN cd /opt/tomee/ && tar xzf apache-maven-3.0.5-bin.tar.gz && rm apache-maven-3.0.5-bin.tar.gz
ENV M2_HOME /opt/tomee/apache-maven-3.0.5
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH
ENV MAVEN_OPTS -Xms256m -Xmx2000m -XX:MaxPermSize=256m

RUN mkdir -p /opt/tomee/sources/
RUN cd /opt/tomee/sources/ && git clone -b tomee-1.7.x https://git-wip-us.apache.org/repos/asf/tomee.git tomee
RUN cd /opt/tomee/sources/tomee && git pull && mvn clean install -DskipTests

CMD ["/bin/bash"]