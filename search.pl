#!/usr/bin/perl

use DBI;
use DBD::mysql;
use CGI qw(:standard);
use header;

print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
END

PrintHeader;

$server = param('server');
$ip = param('ip');

if ($server == '') {
  print "<table align=\"center\" border=\"1\"> \n";
  print "<tr><td>Server</td><td>IP</td><td>Operating System</td><td>Backup Type</td><td>Quota</td><td>Used</td><td>Edit</td></tr>\n";

  my $searchquery = "SELECT server.server, server.ip, server.os, backup_client.backup_type, backup_client.allocated_quota, backup_client.used_quota FROM server, backup_client WHERE server.ip = '$ip' AND server.server = backup_client.server";

  $dbh = DBI->connect("DBI:mysql:$database:$host", $user, $pass);
  $sql = $dbh->prepare($searchquery)
    or die "Can't prepare $searchquery: $dbh->errstr\n";

  $sql->execute();

  while (@data = $sql->fetchrow_array()) {
    $table_server = $data[0];
    $table_ip = $data[1];
    $table_os = $data[2];
    $table_type = $data[3];
    $table_quota = $data[4];
    $table_used = $data[5];

    print "<tr><td>$table_server</td><td>$table_ip</td><td>$table_os</td><td>$table_type</td><td>$table_quota</td><td>$table_used</td><td><a href=\"http://109.104.89.82:9594/edit.pl\"/>Edit</a></td></tr>\n";
}
}

if ($ip == '') {
  print "<table align=\"center\" border=\"1\"> \n";
  print "<tr><td>Server</td><td>IP</td><td>Operating System</td><td>Backup Type</td><td>Quota</td><td>Used</td><td>Edit</td></tr>\n";

  my $searchquery = "SELECT server.server, server.ip, server.os, backup_client.backup_type, backup_client.allocated_quota, backup_client.used_quota FROM server, backup_client WHERE server.server = $server AND server.server = backup_client.server";

  $dbh = DBI->connect("DBI:mysql:$database:$host", $user, $pass);
  $sql = $dbh->prepare($searchquery)
    or die "Can't prepare $searchquery: $dbh->errstr\n";

  $sql->execute();

  while (@data = $sql->fetchrow_array()) {
    $table_server = $data[0];
    $table_ip = $data[1];
    $table_os = $data[2];
    $table_type = $data[3];
    $table_quota = $data[4];
    $table_used = $data[5];

  print "<tr><td>$table_server</td><td>$table_ip</td><td>$table_os</td><td>$table_type</td><td>$table_quota</td><td>$table_used</td><td><a href=\"http://109.104.89.82:9594/edit.pl\"/>Edit</a></td></tr>\n";
}
}
