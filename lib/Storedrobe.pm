use strict;
use warnings;

package Storedrobe;

use Mojo::Base 'Mojolicious';
use Storedrobe::Schema;
use Moose;

our $VERSION = '0.001';

has 'schema' => (
    is => 'ro',
    isa => 'Storedrobe::Schema',
    lazy_build => 1
);

sub startup {
    my $self = shift;
    $self->init_routes();
}

sub init_routes {
    my $self = shift;
    
    my $router = $self->routes();

    $router->post('/clothing/upload-csv')->to('clothing#csv_upload');
    $router->any('/clothing/search/:term')->to('clothing#search');
    $router->any('/clothing/tag/:term')->to('clothing#tag_search');
}
1;
