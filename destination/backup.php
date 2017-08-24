<?php
/**
* Author: Alex Morales
* Instructions:
* script loaded in cron for user xander ( user same user as source ssh login)
* create dir '/home/xander/cronjobs' ... stick this file here
* create dir - /home/xander/backups/rsync/Files/
* create dir - /home/xander/backups/rsync/Config/
* create dir - /home/xander/backups/sites/
* 
* Live example below - change paths/folders to your requirments
**/

date_default_timezone_set('America/Los_Angeles');

/* globals */
$datestring = date('Y') . '-' . date('m') . '-' . date('d') . '-';
$source = '/home/xander/backups/rsync/Files/';
$destination = '/home/xander/backups/sites/';
$csource = '/home/xander/backups/rsync/Config/';
$sites = array('site1.com','site2.com','site3.com','site4.com');

# tarball+gzip rsynced sites
foreach($sites as $site)
{
        $backup_file = $destination . $datestring . $site . '.tgz';
        $command = 'tar cvfzp ' . $backup_file . ' ' . $source . $site . '/*';
        $exec_comm = system($command, $retval);
}

# backup config files
$command = 'tar cvfzp ' . $destination . $datestring . 'config.tgz' . ' ' . $csource . '*';
$exec_comm = system($command, $retval);

# clean up
$back_up_files = array_diff(scandir($destination), array('..', '.'));
foreach($back_up_files as $bfile)
{
        list($bfile_year, $bfile_month, $bfile_day) = explode("-", $bfile);
        $b_time = $bfile_year . '-' . $bfile_month . '-' . $bfile_day;
        $bfile_time = new DateTime($b_time);
        $today_file_time = new DateTime(substr_replace($datestring, "", -1));
        $diff = $today_file_time->diff($bfile_time)->format("%a");

        if($diff > 7) #keep 7 days of backups
        {
                $command = 'rm ' . $destination . $bfile;
                $exec_comm = system($command, $retval);
        }
}
