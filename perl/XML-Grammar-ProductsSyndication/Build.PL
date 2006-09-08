use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'XML::Grammar::ProductsSyndication',
    license             => 'bsd',
    dist_author         => 'Shlomi Fish <shlomif@cpan.org>',
    dist_version_from   => 'lib/XML/Grammar/ProductsSyndication.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'XML::Grammar::ProductsSyndication-*' ],
);

$builder->create_build_script();
