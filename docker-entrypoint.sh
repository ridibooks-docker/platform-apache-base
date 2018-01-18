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
if [ "$XDEBUG_ENABLE" = "1" ]; then
    if [ -f "$XDEBUG_DISABLED" ]; then
        mv $XDEBUG_DISABLED $XDEBUG_ENABLED
    fi;
    # Configure XDebug remote host
    if [ -z "$XDEBUG_HOST" ]; then
        # Allows to set XDEBUG_HOST by env variable because could be different from the one which come from ip route command
        XDEBUG_HOST=$(/sbin/ip route|awk '/default/ { print $3 }')
    fi;
    echo "xdebug.remote_host=$XDEBUG_HOST" > $XDEBUG_REMOTE_HOST
else
    if [ -f "$XDEBUG_ENABLED" ]; then
        mv $XDEBUG_ENABLED $XDEBUG_DISABLED
    fi;
    if [ -f "$XDEBUG_REMOTE_HOST" ]; then
      rm $XDEBUG_REMOTE_HOST
    fi;
fi;

exec docker-php-entrypoint "$@"