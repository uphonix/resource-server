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

    $self->plugin('Config');

    my $router = $self->routes();

    $router->post('/clothing/upload-csv')->to('clothing#csv_upload');
    $router->any('/clothing/search/:term')->to('clothing#search');
    $router->any('/clothing/tag/:term')->to('clothing#tag_search');
}

sub _build_schema {
    my ($self, %config) = @_;

    return Storedrobe::Schema->connect(
	$self->app->config->{db_dsn},
	$self->app->config->{username},
	$self->app->config->{password}
    );
}
1;
