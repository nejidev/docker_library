FROM centos:latest
LABEL maintainer docker_user<nejidev@yahoo.co.jp>

ENV MYSQL_ROOT_PASSWORD 123456

RUN yum install gcc gcc-c++ make ncurses-devel bzip2 perl libxml2-devel openssl-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel -y && yum clean all && rm -rf /var/cache/yum

COPY soft /soft

#build mysql apache php
RUN cd /soft && tar zxvf mysql-5.1.73.tar.gz && cd mysql-5.1.73 && ./configure --prefix=/usr/local/mysql && \
make -j4 && make install && cp support-files/my-medium.cnf /etc/my.cnf && cp support-files/mysql.server /etc/init.d/mysqld && \
sed -i '/skip-locking/a\datadir=/usr/local/mysql/data/ \nbasedir=/usr/local/mysql/ ' /etc/my.cnf && chmod +x /etc/init.d/mysqld && \
useradd mysql -s /usr/sbin/nologin -M && mkdir /usr/local/mysql/data/ && chown mysql:mysql -R /usr/local/mysql/ && \
/usr/local/mysql/bin/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/ --user=mysql && \
/etc/init.d/mysqld start && /usr/local/mysql/bin/mysqladmin -u root password ${MYSQL_ROOT_PASSWORD} && /etc/init.d/mysqld restart && \
rm -rf /usr/local/mysql/mysql-test && rm -rf /usr/local/mysql/docs && rm -rf /usr/local/mysql/share && \
mkdir -p /usr/local/mysql/share/mysql/english/ && cp sql/share/english/errmsg.sys /usr/local/mysql/share/mysql/english/ && \
rm -rf /usr/local/mysql/sql-bench && \
ln -s /usr/local/mysql/bin/mysql /usr/sbin/mysql && ln -s /usr/local/mysql/bin/mysqldump /usr/sbin/mysqldump && \
cd /soft && tar xvf httpd-2.2.34.tar.bz2 && cd httpd-2.2.34 && ./configure --prefix=/usr/local/httpd2.2 --enable-so --enable-rewrite --with-zlib --with-pcre --enable-ssl --enable-modules=all --enable-mods-shared=all && \
make -j4 && make install && cp /usr/local/httpd2.2/bin/apachectl /etc/init.d/httpd && \
rm -rf /usr/local/httpd2.2/man && rm -rf /usr/local/httpd2.2/manual && \
cd /soft && tar xvf php-5.5.38.tar.xz && cd php-5.5.38 && \
./configure --prefix=/usr/local/php --with-apxs2=/usr/local/httpd2.2/bin/apxs --with-openssl --with-libxml-dir --with-zlib --with-curl --enable-exif --with-pcre-dir \
--with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-gd-native-ttf --enable-gd-jis-conv --with-gettext --enable-mysqlnd \
--with-mysql-sock=/tmp/mysql.sock --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --enable-zip --with-iconv-dir && \
make -j4 && make install && cp php.ini-production /usr/local/php/lib/php.ini && \
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.php/' /usr/local/httpd2.2/conf/httpd.conf && \
sed -i '/#AddHandler cgi-script .cgi/a\AddType application/x-httpd-php .php' /usr/local/httpd2.2/conf/httpd.conf && \
echo -e "<?php \nphpinfo();" > /usr/local/httpd2.2/htdocs/phpinfo.php && chmod +x /usr/local/httpd2.2/htdocs/phpinfo.php && \
cd /soft && chmod +x hang.sh && cp hang.sh / && rm -rf /soft

EXPOSE 80

CMD ["/hang.sh"]
