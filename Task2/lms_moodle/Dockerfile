FROM centos:7

RUN yum install epel-release -y \
    && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    && rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-7.noarch.rpm \
    && yum --enablerepo=remi-php72 install php php-mysql php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt -y

RUN yum --enablerepo=epel,remi install httpd -y \
    && yum install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache -y \
    && yum-config-manager --enable remi-php72 \
    && yum install php-pecl-zip php-intl -y \
    && yum install php-pgsql -y

RUN yum install wget -y \
    && wget https://download.moodle.org/download.php/direct/stable37/moodle-3.7.1.tgz -q \
    && tar -zxvf moodle-3.7.1.tgz -C /var/www/html \
    && mkdir /var/www/html/moodledata \
    && chmod -R 0755 /var/www/html/moodle \
    && chown -R apache.apache /var/www/html/moodle \
    && chmod -R 777 /var/www/html/moodledata \
    && chown -R apache.apache /var/www/html/moodledata

COPY moodle.sii2019devops.com.conf /etc/httpd/conf.d/moodle.sii2019devops.com.conf

COPY add_opcache.sh /tmp/add_opcache.sh
RUN /tmp/add_opcache.sh
ENV MOODLE_DB_USER=moodle_devops
ENV MOODLE_DB_PASSWORD=1qaz2wsx
ENV MOODLE_DB_DATABASE=moodle
ENV POSTGRES_USER=postgres
ENV IP_DOCKER_LMS=http://192.168.56.20
#ENV IP_DOCKER_DB=192.168.56.20
RUN /usr/bin/php /var/www/html/moodle/admin/cli/install.php --wwwroot="$IP_DOCKER_LMS" --dataroot='/var/www/html/moodledata' --dbtype='pgsql' --dbhost="$IP_DOCKER_DB" --dbname='moodle' --dbuser='moodle_devops' --dbpass="$MOODLE_DB_PASSWORD" --dbport='5432'  --shortname='moodle.local' --adminuser='admin' --adminpass='1qaz2wsx' --adminemail='admin@yo.lo' --fullname='moodle.IF-101-devops' --non-interactive --agree-license 
RUN chmod o+r /var/www/html/moodle/config.php

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

