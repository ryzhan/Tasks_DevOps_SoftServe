FROM centos:centos7
ENV DB_ROOT_PWD='1qaz2wsx'
ENV DB_USER_PWD='1qaz2wsx'

RUN yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y \
    && yum install postgresql94-server postgresql94-contrib postgresql94-libs postgresql94-devel -y \
    && /usr/pgsql-9.4/bin/postgresql94-setup initdb \
    && systemctl start postgresql-9.4.service \
    && systemctl enable postgresql-9.4.service \
    && psql -U postgres <<_EOF_
        CREATE USER moodle_devops WITH PASSWORD '1qaz2wsx';
        CREATE DATABASE moodle WITH OWNER moodle_devops ENCODING 'UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0;
        _EOF_ \
    && sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '192.168.56.20'/" /var/lib/pgsql/9.4/data/postgresql.conf \
    && echo "host all all 192.168.56.10/32 md5" >> /var/lib/pgsql/9.4/data/pg_hba.conf \
    && systemctl restart postgresql-9.4.service

CMD tail -f /dev/null
ENTRYPOINT ["/bin/bash"]
EXPOSE 5432