FROM centos:7
RUN yum install -y wget java-1.7.0-openjdk java-1.7.0-openjdk-devel unzip git
RUN wget "https://archive.apache.org/dist/maven/binaries/apache-maven-2.2.1-bin.zip"
RUN unzip apache-maven-2.2.1-bin.zip
ENV PATH /apache-maven-2.2.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk
RUN mkdir m2_repo
COPY travis-settings.xml m2_repo/
RUN mkdir build;mkdir -p /root/.m2
COPY org /root/.m2/
CMD cd build;git clone $CLONEPATH src; cd src; mvn -Dmaven.repo.local=/m2_repo clean package
