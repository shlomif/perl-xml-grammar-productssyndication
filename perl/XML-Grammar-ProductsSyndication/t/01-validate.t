#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 10;

use XML::Grammar::ProductsSyndication;
use File::Spec;

my @xml_files = (
"001-empty-cat.xml",  # TEST
"002-nested-cat.xml", # TEST
"0030-with-one-product.xml", # TEST
"0031-with-products.xml", # TEST
"004-products-with-creators.xml", # TEST
"005-refs.xml", # TEST
"006-xhtml.xml", # TEST
"007-xhtml-2.xml", # TEST
"008-xhtml-3.xml", # TEST
"009-set.xml", # TEST
);

foreach my $xml_file (@xml_files)
{
    my $p = XML::Grammar::ProductsSyndication->new(
        {
            'source' =>
            {
                'file' => 
                    File::Spec->catfile("t", "data", "valid-xmls", $xml_file),
            },
            'data_dir' => File::Spec->catdir("blib", "extradata"),
        }
    );
    ok ($p->is_valid(), "Checking for validation of '$xml_file'");
}

