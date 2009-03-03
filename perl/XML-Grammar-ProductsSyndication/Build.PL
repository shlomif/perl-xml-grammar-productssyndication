use strict;
use warnings;

use File::Spec;
use lib File::Spec->catdir(File::Spec->curdir(), "inc");

use XML::Grammar::Builder;

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
);

$builder->create_build_script();

