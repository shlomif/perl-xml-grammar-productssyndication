#!/usr/bin/perl

use strict;
use warnings;

use Test::XML tests => 3;
use IO::All;

use XML::LibXML;
use XML::LibXSLT;

sub get_files_list
{
    return (grep { /\.xml$/ } io("./valid-xmls")->all());
}

my @xml_files = get_files_list();

# TEST:$num_xslt=3
# TEST*$num_xslt
foreach my $xml_file (@xml_files[0 .. 2])
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
