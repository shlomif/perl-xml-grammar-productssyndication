#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 8;
use IO::All;

use XML::LibXML;

# TEST:$num_files=8
# TEST*$num_files
my $dtd =
    XML::LibXML::Dtd->new(
            "Products Syndication Markup Language 0.1.1",
            "products-syndication.dtd",
            );

foreach my $xml_file (io("./valid-xmls")->all())
{
    if ($xml_file =~ /\.xml$/)
    {
        my $p = XML::LibXML->new();
        $p->validation(0);
        my $dom = $p->parse_file($xml_file);
        ok ($dom->validate($dtd));
    }
}
