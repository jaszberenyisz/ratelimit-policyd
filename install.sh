#!/bin/bash

# get current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd "$DIR"

# assure our logfile belongs to user postfix
touch /var/log/ratelimit-policyd.log
chown postfix:postfix /var/log/ratelimit-policyd.log

# install init script
chmod 755 daemon.pl init.d/ratelimit-policyd
ln -sf "$DIR/init.d/ratelimit-policyd" /etc/init.d/
insserv ratelimit-policyd

# systemd files
rm -f /lib/systemd/system/ratelimit.service
cp "$DIR/lib/systemd/system/ratelimit.service" "/lib/systemd/system/"
rm -f /etc/systemd/system/ratelimit.service
ln -s "/lib/systemd/system/ratelimit.service" "/etc/systemd/system/"

# install logrotation configuration
ln -sf "$DIR/logrotate.d/ratelimit-policyd" /etc/logrotate.d/

exit 0
