use strict;
use warnings;

use File::Spec;
use lib File::Spec->catdir(File::Spec->curdir(), "inc");

use Test::Run::Builder;

use File::Find;

sub data_inc
{
    return "/usr/share/perl5/data/modules/XML-Grammar-Products-Syndication/data";
}

my @extradata_files;

sub filter_files
{
    my $filename = $File::Find::name;
    if ((-f $filename) && ($filename =~ /\.(?:mod|xslt|dtd|ent|cat)$/))
    {
        push @extradata_files, $filename;
    }
}

find({ wanted => \&filter_files, no_chdir => 1}, "extradata");

my $builder = Test::Run::Builder->new(
    module_name         => 'XML::Grammar::ProductsSyndication',
    license             => 'bsd',
    dist_author         => 'Shlomi Fish <shlomif@cpan.org>',
    dist_version_from   => 'lib/XML/Grammar/ProductsSyndication.pm',
    build_requires => {
        'Test::More' => 0,
        'Test::XML' => 0,
        'XML::LibXML' => 0,
        'XML::LibXSLT' => 0,
        'Moose' => 0,
    },
    add_to_cleanup      => [ 'XML::Grammar::ProductsSyndication-*' ],
    create_makefile_pl => 'passthrough',
    install_path =>
    {
        extradata => data_inc(),
    },
    extradata_files => 
    {
        map { $_ => $_ } @extradata_files,
    },
);

$builder->add_build_element('extradata');
$builder->install_path->{'extradata'} = $builder->prefix() . "/data/modules/XML-Grammar-Products-Syndication/data";

$builder->config_data('extradata_install_path' => [$builder->install_path->{'extradata'}]);

$builder->create_build_script();
