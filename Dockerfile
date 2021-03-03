FROM centos:7

ENV container docker

RUN yum -y install wget
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo
#COPY ./install/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
COPY ./install/hadoop-3.2.2.tar.gz /
COPY ./install/jdk-8u281-linux-x64.tar.gz /
#RUN yum clean all
RUN yum makecache
RUN yum update -y

RUN yum install -y net-tools
RUN yum install -y openssh-server.x86_64
RUN yum install -y openssh-clients.x86_64
RUN yum install -y which
RUN yum install -y vim
RUN yum install -y sudo
RUN yum install -y vsftpd
RUN yum install -y expect

#RUN useradd hadoop && echo "hadoop" | passwd --stdin "hadoop"
RUN echo -e "root\nroot" | passwd

WORKDIR /

RUN tar -xzf hadoop-3.2.2.tar.gz -C /usr/local
RUN mv /usr/local/hadoop-3.2.2 /usr/local/hadoop

RUN tar -xzf jdk-8u281-linux-x64.tar.gz -C /usr/local
COPY ./hadoop /usr/local/hadoop/etc/hadoop

RUN mkdir -p /usr/local/data/hadoop/name
RUN mkdir -p /usr/local/data/hadoop/data
RUN mkdir -p /usr/local/data/hadoop/tmp
RUN mkdir -p /usr/local/data/hadoop/secondary
RUN chmod 777 -R /usr/local/data/hadoop

RUN echo export JAVA_HOME=/usr/local/jdk1.8.0_281/ >> /root/.bash_profile
RUN echo export HADOOP_HOME=/usr/local/hadoop/ >> /root/.bash_profile
RUN echo export PATH=\$PATH:\$JAVA_HOME/bin:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin >> /root/.bash_profile
RUN source /root/.bash_profile

COPY ssh.sh /root/
COPY auth.exp /root/

CMD ["/usr/sbin/init"]
