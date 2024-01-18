<?php
/**
 * using mysqli_connect for database connection
 */
 
$databaseHost = 'mariadb_ttl_sh';
$databaseName = 'crud_db';
$databaseUsername = 'root';
$databasePassword = 'password';
 
$mysqli = mysqli_connect($databaseHost, $databaseUsername, $databasePassword, $databaseName); 
 
?>