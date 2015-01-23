package Storedrobe;

=head1 Storedrobe

A small Mojolicious application to manage clothing items

Routes:
  /clothing/upload-csv            - upload CSV file
  /clothing/:item_id/tag/:term    - add new tag to a clothing item
  /clothing/search/:term          - search clothing items by name
  /clothing/search/tag/:term      - search clothing items by tag
  /clothing/search/category/:term - get clothing items by category name

See class Storedrobe::Clothing for more docs on routes.

=cut

use strict;
use warnings;
use Mojo::Base 'Mojolicious';
use Storedrobe::Schema;
use Moose;

our $VERSION = '0.1';

has 'schema' => (
    is => 'ro',
    isa => 'Storedrobe::Schema',
    lazy_build => 1,
    required => 1,
);

=head2 startup

Main entry point into app, sets up config and routes

=cut

sub startup {
    my $self = shift;

    $self->plugin('Config');
    $self->plugin('Mojolicious::Plugin::UTF8'); # set utf8 charset in response headers

    my $r = $self->routes;

    $r->post('/clothing/upload-csv')->to('clothing#csv_upload');
    $r->post('/clothing/:item_id/tag/:term')->to('clothing#tag_item');

    $r->any('/clothing/search/:term')->to('clothing#search');
    $r->any('/clothing/search/tag/:term')->to('clothing#tag_search');
    $r->any('/clothing/search/category/:term')->to('clothing#category_search');

}

# build schema object by connecting to DB with args from config
sub _build_schema {
    my ($self, %config) = @_;

    return Storedrobe::Schema->connect(@{ $self->config->{db} });
}

1;
