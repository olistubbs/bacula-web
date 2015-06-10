#!/usr/bin/perl
#

sub PrintHeader {
print "<title>Bacula Web App</title>";

print "<body align=\"center\"> THIS IS IN DEV DO NOT USE</body>";

print "<form align=\"center\" action=\"http://109.104.89.82:9594/search.pl\" method=\"post\">";
print "<div align=\"center\">Server: <input name=\"server\" size=\"10\"></div>";
print "<div align=\"center\">IP: <input name=\"ip\" size=\"15\"><input type=\"submit\"></div>";

print "<table align=\"center\" border=\"0\"> \n";
print "<tr><td><a href=\"http://109.104.89.82:9594/add.pl\"/>Add</a></td><tr>";
print "</table>";
}

1;
