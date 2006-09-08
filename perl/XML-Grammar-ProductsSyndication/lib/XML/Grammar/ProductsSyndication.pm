package XML::Grammar::ProductsSyndication;

use warnings;
use strict;

=head1 NAME

XML::Grammar::ProductsSyndication - an XML Grammar for ProductsSyndication.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    my $syndicate = 
        XML::Grammar::ProductsSyndication->new(
            {
                'source' =>
                {
                    'file' => "products.xml",
                },
            }
        );

    # A LibXML compatible XHTML DOM
    my $xhtml = $syndicate->get_xhtml();

    $syndicate->download_preview_images(
        {
            'dir' => "mydir/",
        }
        );

=head1 FUNCTIONS

=head1 AUTHOR

Shlomi Fish, C<< <shlomif at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-xml-grammar-productssyndication at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XML::Grammar::ProductsSyndication>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc XML::Grammar::ProductsSyndication

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/XML::Grammar::ProductsSyndication>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/XML::Grammar::ProductsSyndication>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=XML::Grammar::ProductsSyndication>

=item * Search CPAN

L<http://search.cpan.org/dist/XML::Grammar::ProductsSyndication>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006 Shlomi Fish, all rights reserved.

This program is released under the following license: bsd

=cut

1; # End of XML::Grammar::ProductsSyndication
