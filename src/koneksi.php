<?php
$host = "mariadb_ttl_sh";
$user = "root";
$pass = "password";
$nama_db = "crud_gc"; //nama database
$koneksi = mysqli_connect($host, $user, $pass, $nama_db); //pastikan urutan nya seperti ini, jangan tertukar

if (mysqli_connect_errno()) { //jika tidak terkoneksi maka akan tampil error
    die("Koneksi dengan database gagal: " . mysqli_connect_error());
}
