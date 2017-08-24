#!/bin/bash
# Author: Alex
# Instructions
# upload this file to '/root/cronjobs/'
# create SSH Keygen - https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/
# Live example below.. this script will need to be customized to your requirements.

#site1.com
bgbdestination="/home/xander/backups/rsync/Files/site1.com/"
bgbsource="/var/www/vhosts/site1.com/httpdocs"
rsync -avp --rsh='ssh' --stats --progress --delete $bgbsource "xander@backup:$bgbdestination/"

#site2.com
bgdestination="/home/xander/backups/rsync/Files/site2.com/"
bgsource="/var/www/vhosts/site2.com/httpdocs"
bgexclude1="content/cache"
rsync -avp --exclude=$bgexclude1 --exclude='*.zip' --exclude='*.gz' --exclude='*.gzip' --exclude='*.tar' --rsh='ssh' --stats --progress --delete $bgsource "xander@backup:$bgdestination/"

#site3.com
yfdestination="/home/xander/backups/rsync/Files/site3.com/"
yfsource="/var/www/vhosts/site3.com/httpdocs"
yfexclude1="var/session"
yfexclude2="var/po_fpc"
yfexclude3="var/log"
yfexclude4="var/cache"
yfexclude5="media/cache"
yfexclude6="media/catalog/product/cache"
rsync -avp --exclude=$yfexclude1 --exclude=$yfexclude2 --exclude=$yfexclude3 --exclude=$yfexclude4 --exclude=$yfexclude5 --exclude=$yfexclude6 --exclude='*.zip' --exclude='*.gz' --exclude='*.gzip' --exclude='*.tar' --rsh='ssh' --stats --progress --delete $yfsource "xander@backup:$yfdestination/"

#mag 2 multi sites
mag2destination="/home/xander/backups/rsync/Files/dev.site2.com/"
mag2source="/var/www/vhosts/dev.site2.com/httpdocs"
mag2exclude1="var/cache"
mag2exclude2="var/page_cache"
mag2exclude3="var/log"
mag2exclude4="var/report"
mag2exclude5="var/view_preprocessed"
mag2exclude6="pub/static"
rsync -avp --exclude=$mag2exclude1 --exclude=$mag2exclude2 --exclude=$mag2exclude3 --exclude=$mag2exclude4 --exclude=$mag2exclude5 --exclude=$mag2exclude6 --exclude='*.zip' --exclude='*.gz' --exclude='*.gzip' --exclude='*.tar' --rsh='ssh' --stats --progress --delete $mag2source "xander@backup:$mag2destination/"

#server config files
cdestination="/home/xander/backups/rsync/Config/"
csource1  = "/etc/redis*"
csource2  = "/etc/nginx"
csource3  = "/etc/httpd"
csource4  = "/etc/my.cnf"
csource5  = "/etc/varnish"
csource6 = "/etc/php.d"
csource7 = "/opt/plesk/"
csource8 = "/etc/fstab"
csource9 = "/etc/passwd"
csource10 = "/etc/group"
csource11 = "/etc/php-fpm.conf"
csource12 = "/etc/php-fpm.d"
rsync -avp --rsh='ssh' --stats --progress $csource1 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource2 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource3 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource4 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource5 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource6 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource7 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource8 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource9 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource10 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource11 "xander@backup:$cdestination/"
rsync -avp --rsh='ssh' --stats --progress $csource12 "xander@backup:$cdestination/"

exit 0