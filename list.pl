#!/usr/bin/perl

#print "Content-type: text/html\n\n";

use DBI;
use DBD::mysql;

use CGI qw(:standard);

use warnings;

my $database = 'backups';
my $host = 'localhost';
my $user = 'backup';
my $pass = "--Redacted--";

print header;

print "<table align=\"center\" border=\"0\"> \n";
print "<tr><td><a href=\"http://109.104.89.82:9594/add.pl\"/>Add</a></td><tr>";
print "</table>";

print "<table align=\"center\" border=\"1\"> \n";

print "<tr><td>Server</td><td>IP</td><td>Operating System</td><td>Backup Type</td><td>Quota</td><td>Used</td><td>Edit</td></tr>\n";

$query = "SELECT server.server, server.ip, server.os, backup_client.backup_type, backup_client.allocated_quota, backup_client.used_quota FROM server, backup_client WHERE server.server = backup_client.server";

$dbh = DBI->connect("DBI:mysql:$database:$host", $user, $pass);
$sql = $dbh->prepare($query)
  or die "Can't prepare $query: $dbh->errstr\n";

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

print "</table>";

exit;
