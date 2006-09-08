#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 10;
use IO::All;

use XML::LibXML;

# TEST:$num_files=9
# TEST*$num_files
my $dtd =
    XML::LibXML::Dtd->new(
            "Products Syndication Markup Language 0.1.1",
            "product-syndication.dtd",
            );

my @xml_files = (grep { /\.xml$/ } io("./valid-xmls")->all());
foreach my $xml_file (@xml_files)
{
    my $p = XML::LibXML->new();
    $p->validation(0);
    my $dom = $p->parse_file($xml_file);
    ok ($dom->validate($dtd));
}

