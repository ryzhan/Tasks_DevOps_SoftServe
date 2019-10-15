#!/bin/bash

echo "<<<<<<<<<<<<<<<<<< Opcache php.ini >>>>>>>>>>>>>>>>>>>>"

/bin/cat <<EOM >/etc/php.ini
zend_extension=/opt/remi/php72/root/usr/lib64/php/modules/opcache.so

[opcache]
opcache.enable = 1
opcache.memory_consumption = 128
opcache.max_accelerated_files = 10000
opcache.revalidate_freq = 60

opcache.use_cwd = 1
opcache.validate_timestamps = 1
opcache.save_comments = 1
opcache.enable_file_override = 0
EOM