package XML::Grammar::ProductsSyndication;

use warnings;
use strict;

use XML::Grammar::ProductsSyndication::ConfigData;
use XML::LibXML;
use XML::LibXSLT;

use Moose;

has '_filename' => (isa => 'Str', is => 'rw');
has '_data_dir' => (isa => 'Str', is => 'rw');
has '_xml_parser' => (isa => "XML::LibXML", is => 'rw');
has '_stylesheet' => (isa => "XML::LibXSLT::StylesheetWrapper", is => 'rw');

=head1 NAME

XML::Grammar::ProductsSyndication - an XML Grammar for ProductsSyndication.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use XML::Grammar::ProductsSyndication;

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

=head2 XML::Grammar::ProductsSyndication->new({ arg1 => "value"...})

The constructor - accepts a single hash reference with the following keys:

=over 4

=item 'source'

A reference to a hash that contains the information for the source XML for the
file. Currently supported is a C<'file'> key that contains a path to the file.

=item 'data_dir'

Points to the data directory where the DTD files, the XSLT stylesheet, etc.
are stored. Should not be generally over-ridden.

=back

=cut

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init(@_);
    return $self;
}

sub _init
{
    my ($self, $args) = @_;

    my $source = $args->{'source'} or
        die "did not specify the source";
    
    my $file = $source->{file};

    $self->_filename($file);

    my $data_dir = $args->{'data_dir'} ||
        XML::Grammar::ProductsSyndication::ConfigData->config('extradata_install_path')->[0];

    $self->_data_dir($data_dir);
    return 0;
}

sub _get_xml_parser
{
    my $self = shift;

    if (!defined($self->_xml_parser()))
    {
        $self->_xml_parser(XML::LibXML->new());
        $self->_xml_parser()->validation(0);
    }
    return $self->_xml_parser();
}

sub _get_source_dom
{
    my $self = shift;

    return $self->_get_xml_parser()->parse_file($self->_filename());
}

=head2 $processor->is_valid()

Checks if the filename validates according to the DTD.

=cut

sub is_valid
{
    my $self = shift;

    my $dtd = 
        XML::LibXML::Dtd->new(
            "Products Syndication Markup Language 0.1.1",
            File::Spec->catfile(
                $self->_data_dir(), 
                "product-syndication.dtd"
            ),
        );

    return $self->_get_source_dom()->validate($dtd);
}

sub _get_stylesheet
{
    my $self = shift;

    if (!defined($self->_stylesheet()))
    {
        my $xslt = XML::LibXSLT->new();

        my $style_doc = $self->_get_xml_parser()->parse_file(
                File::Spec->catfile(
                    $self->_data_dir(), 
                    "product-syndication.xslt"
                ),
            );

        $self->_stylesheet($xslt->parse_stylesheet($style_doc));
    }
    return $self->_stylesheet();
}

=head2 $processor->transform_into_html({ 'output' => $output, })

Transforms the output into HTML, and returns the results. If C<'output'> is 
C<'xml'> returns the L<XML::LibXML> XML DOM. If C<'output'> is C<'string'>
returns the XML as a monolithic string. Other C<'output'> formats are
undefined.

=cut

sub transform_into_html
{
    my ($self, $args) = @_;

    my $source_dom = $self->_get_source_dom();
    my $stylesheet = $self->_get_stylesheet();

    my $results = $stylesheet->transform($source_dom);

    my $medium = $args->{output};

    if ($medium eq "string")
    {
        return $stylesheet->output_string($results);
    }
    elsif ($medium eq "xml")
    {
        return $results;
    }
    else
    {
        die "Unknown medium";
    }
}
=begin unused

=head2 $processor->meta();

This is to settle the Pod::Coverage. meta() is probably inserted by Moose.

=end unused

=cut

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
