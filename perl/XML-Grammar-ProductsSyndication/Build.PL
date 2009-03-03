use strict;
use warnings;

use File::Spec;
use lib File::Spec->catdir(File::Spec->curdir(), "inc");

use Test::Run::Builder;

use File::Find;

my @extradata_files;

my @module_ns = (qw(XML Grammar ProductsSyndication));
my $module_name = join("-", @module_ns);

sub filter_files
{
    my $filename = $File::Find::name;
    if ((-f $filename) && ($filename =~ /\.(?:mod|xslt|dtd|ent|cat|jpg|xcf\.bz2)$/))
    {
        push @extradata_files, $filename;
    }
}

find({ wanted => \&filter_files, no_chdir => 1}, "extradata");

sub get_dest_extradata_file
{
    my $fn = shift;
    $fn =~ s{^extradata}{data};
    return "lib/$module_name/$fn";
}

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
        'Class::Accessor' => 0,
        'XML::Amazon' => 0,
        'LWP::UserAgent' => 0,
        'Imager' => 0,
    },
    add_to_cleanup      => [ 'XML::Grammar::ProductsSyndication-*' ],
    create_makefile_pl => 'passthrough',
    extradata_files => 
    {
        (map { $_ => get_dest_extradata_file($_) } @extradata_files)
    },
);

$builder->add_build_element('extradata');

$builder->install_path()->{'extradata'} = 
        File::Spec->catdir(
                $builder->install_destination("lib"),
                qw(data modules),
                $module_name,
                qw(data)
        );

$builder->config_data(
    'extradata_install_path' =>
    [$builder->install_path()->{'extradata'}]
);

$builder->create_build_script();
