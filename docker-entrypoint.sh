#!/usr/bin/env bash

set -e

# Configure PHP date.timezone
echo "date.timezone = $PHP_TIMEZONE" > /usr/local/etc/php/conf.d/timezone.ini

# Configure Apache Document Root
mkdir -p $APACHE_DOC_ROOT
chown www-data:www-data $APACHE_DOC_ROOT
sed -i "s|DocumentRoot /var/www/html\$|DocumentRoot $APACHE_DOC_ROOT|" /etc/apache2/sites-available/000-default.conf
echo "<Directory $APACHE_DOC_ROOT>" > /etc/apache2/conf-available/document-root-directory.conf
echo "  AllowOverride All" >> /etc/apache2/conf-available/document-root-directory.conf
echo "  Require all granted" >> /etc/apache2/conf-available/document-root-directory.conf
echo "</Directory>" >> /etc/apache2/conf-available/document-root-directory.conf
a2enconf "document-root-directory.conf"

PHP_INI_PATH=/usr/local/etc/php/conf.d
XDEBUG_DISABLED=$PHP_INI_PATH/99-xdebug.ini.disabled
XDEBUG_ENABLED=$PHP_INI_PATH/99-xdebug.ini
XDEBUG_REMOTE_HOST=$PHP_INI_PATH/xdebug_remote_host.ini

# Enable XDebug if needed
PHP_INI_DIR=/usr/local/etc/php/conf.d
PHP_XDEBUG_INI=${PHP_INI_DIR}/99-xdebug.ini
PHP_XDEBUG_HOST=${XDEBUG_HOST:-host.docker.internal}
PHP_EXTENSION_DIR=$(php-config --extension-dir)
if [ "${XDEBUG_ENABLE}" == "1" ]
then
    cp ${PHP_XDEBUG_INI}.tmpl ${PHP_XDEBUG_INI}
    sed -i "s|\$EXTENSION_DIR|${PHP_EXTENSION_DIR}|" ${PHP_XDEBUG_INI}

    echo "Set XDebug remote host \"${PHP_XDEBUG_HOST}\""
    sed -i "s|\$XDEBUG_REMOTE_HOST|${PHP_XDEBUG_HOST}|" ${PHP_XDEBUG_INI}
elif [ -f "${PHP_XDEBUG_INI}" ]
then
    rm ${PHP_XDEBUG_INI}
fi

exec docker-php-entrypoint "$@"
