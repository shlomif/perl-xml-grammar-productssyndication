#!/usr/bin/perl

use strict;
use warnings;

use IO::All;

my $mod_name = "XML-Grammar-ProductsSyndication";

my $fn = $mod_name;

$fn =~ s{-}{/}g;

$fn = "./lib/$fn.pm";

my ($version) = 
    (map { m{\$VERSION *= *'([^']+)'} ? ($1) : () } 
    io->file($fn)->getlines()
    )
    ;

if (!defined ($version))
{
    die "Version is undefined!";
}


my @cmd = (
    "svn", "copy", "-m",
    "Tagging the $mod_name as release $version",
    "https://svn.berlios.de/svnroot/repos/web-cpan/$mod_name/trunk",
    "https://svn.berlios.de/svnroot/repos/web-cpan/$mod_name/tags/releases/modules/$mod_name/$version",
);

print join(" ", @cmd), "\n";
exec(@cmd);
