package Storedrobe;

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

sub startup {
    my $self = shift;

    $self->plugin('Config');

    my $r = $self->routes;

    $r->post('/clothing/upload-csv')->to('clothing#csv_upload');
    $r->post('/clothing/item/:item_id/tag/:term')->to('clothing#tag_item');

    $r->any('/clothing/search/:term')->to('clothing#search');
    $r->any('/clothing/search/tag/:term')->to('clothing#tag_search');
    $r->any('/clothing/search/category/:term')->to('clothing#category_search');

}

sub _build_schema {
    my ($self, %config) = @_;

    return Storedrobe::Schema->connect(@{ $self->config->{db} });
}

1;
