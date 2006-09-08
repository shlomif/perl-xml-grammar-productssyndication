#!/usr/bin/perl

use strict;
use warnings;

use Test::XML tests => 10;
use IO::All;

use XML::LibXML;
use XML::LibXSLT;

sub get_files_list
{
    my @files = 
    (
    "valid-xmls/001-empty-cat.xml", # TEST
    "valid-xmls/002-nested-cat.xml", # TEST
    "valid-xmls/0030-with-one-product.xml", # TEST
    "valid-xmls/0031-with-products.xml", # TEST
    "valid-xmls/004-products-with-creators.xml", # TEST
    "valid-xmls/005-refs.xml", # TEST
    "valid-xmls/006-xhtml.xml", # TEST
    "valid-xmls/007-xhtml-2.xml", # TEST
    "valid-xmls/008-xhtml-3.xml", # TEST
    "valid-xmls/009-set.xml", # TEST
    );
    return @files;
}

my @xml_files = get_files_list();

foreach my $xml_file (@xml_files)
{
    my $parser = XML::LibXML->new();
    my $xslt = XML::LibXSLT->new();

    my $source = $parser->parse_file($xml_file);
    my $style_doc = $parser->parse_file("product-syndication.xslt");
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
