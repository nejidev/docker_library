#!/bin/bash
/etc/init.d/httpd start
/etc/init.d/mysqld start
tail -f /usr/local/httpd2.2/logs/error_log
