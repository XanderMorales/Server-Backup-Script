<?php
/**
* Author: Alex Morales
* Instructions:
* Edit global varaibles below
* create dir '/root/cronjobs' ... stick this file here
* create dir 'root/backup/db/'
*/
date_default_timezone_set('America/Los_Angeles');

/* globals */
$ftp_server = 'IP';
$ftp_user_name = 'user';
$ftp_user_pass = 'pass';
$databases = array('DBNAME1_TO_BACKUP','DBNAME2_TO_BACKUP','DBNAME3_TO_BACKUP','DBNAME4_TO_BACKUP');
$dbuser = 'dbuser name';
$dbpass = 'dbuser password';
$datestring = date('Y') . '-' . date('m') . '-' . date('d');

MyDBDumpPut();

/**
* Dumps db
*
**/
function MyDBDumpPut()
{
        global $databases,$ftp_server, $ftp_user_name, $ftp_user_pass, $datestring;;

        foreach($databases as $name)
        {
                $yf_db_name = $datestring . '-' . $name . '.sql';
                $yfmag_local_path = '/root/backup/db/' . $yf_db_name;
                $yfmag_dump_command = "mysqldump --user='$dbuser' --password='$bdpass' $name > $yfmag_local_path";
                system($yfmag_dump_command, $retval);

                $conn_id = ftp_connect($ftp_server);
                $login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);
                ftp_pasv($conn_id, true);
                ftp_chdir($conn_id,"/backups/db/");
                ftp_put($conn_id, $yf_db_name, $yfmag_local_path, FTP_ASCII);
                ftp_close($conn_id);

                $del_command = 'rm ' . $yfmag_local_path;
                system($del_command, $retval);
        }
}