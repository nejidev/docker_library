FROM centos:latest
LABEL maintainer docker_user<nejidev@yahoo.co.jp>
ENV MYSQL_ROOT_PASSWORD 123456
RUN yum install gcc gcc-c++ make ncurses-devel bzip2 -y && yum clean all && rm -rf /var/cache/yum

COPY soft /soft

#build mysql
RUN cd /soft && tar zxvf mysql-5.1.73.tar.gz && cd mysql-5.1.73 && ./configure --prefix=/usr/local/mysql && \
make -j4 && make install && cp support-files/my-medium.cnf /etc/my.cnf && cp support-files/mysql.server /etc/init.d/mysqld && \
sed -i '/skip-locking/a\datadir=/usr/local/mysql/data/ \nbasedir=/usr/local/mysql/ ' /etc/my.cnf && chmod +x /etc/init.d/mysqld && \
useradd mysql -s /usr/sbin/nologin -M && mkdir /usr/local/mysql/data/ && chown mysql:mysql -R /usr/local/mysql/ && \
/usr/local/mysql/bin/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/ --user=mysql && \
/etc/init.d/mysqld start && /usr/local/mysql/bin/mysqladmin -u root password ${MYSQL_ROOT_PASSWORD} && /etc/init.d/mysqld restart && \
rm -rf /usr/local/mysql/mysql-test && rm -rf /usr/local/mysql/docs && rm -rf /usr/local/mysql/share && \
mkdir -p /usr/local/mysql/share/mysql/english/ && cp sql/share/english/errmsg.sys /usr/local/mysql/share/mysql/english/ && \
rm -rf /usr/local/mysql/sql-bench && cd .. && rm -rf mysql-5.1.73

RUN ln -s /usr/local/mysql/bin/mysql /usr/sbin/mysql && ln -s /usr/local/mysql/bin/mysqldump /usr/sbin/mysqldump

#build apache httpd
RUN cd /soft && tar xvf httpd-2.2.34.tar.bz2 && cd httpd-2.2.34 && ./configure --prefix=/usr/local/httpd2.2 --enable-so --enable-rewrite && \
make -j4 && make install && cp /usr/local/httpd2.2/bin/apachectl /etc/init.d/httpd && cd .. rm -rf httpd-2.2.34 && rm -rf /usr/local/httpd2.2/man && \
rm -rf /usr/local/httpd2.2/manual

EXPOSE 80

CMD ["/etc/init.d/httpd", "start"]
CMD ["/etc/init.d/mysqld", "start"]
CMD ["bash"]

