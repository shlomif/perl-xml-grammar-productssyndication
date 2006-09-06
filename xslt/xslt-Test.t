#!/usr/bin/perl

use strict;
use warnings;

use Test::XML tests => 2;
use IO::All;

use XML::LibXML;
use XML::LibXSLT;

my @xml_files = (grep { /\.xml$/ } io("./valid-xmls")->all());

# TEST:$num_xslt=2
# TEST*$num_xslt
foreach my $xml_file (@xml_files[0 .. 1])
{
    my $parser = XML::LibXML->new();
    my $xslt = XML::LibXSLT->new();

    my $source = $parser->parse_file($xml_file);
    my $style_doc = $parser->parse_file("products-syndication.xslt");
    my $stylesheet = $xslt->parse_stylesheet($style_doc);

    my $results = $stylesheet->transform($source);

    my $expected = io()->file(get_expected_fn($xml_file))->slurp();
    my $got = $stylesheet->output_string($results);
    is_xml(
        $got,
        $expected,
        "Testing output of XSLT with file $xml_file",
    );
}

sub get_expected_fn
{
    my $file = shift;
    if ($file =~ m{^(?:\./)?valid-xmls/(.*)\.xml$})
    {
        return "./outputs/$1.html";
    }
    else
    {
        die "Unknown filename";
    }
}
