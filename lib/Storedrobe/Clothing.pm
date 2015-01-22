package Storedrobe::Clothing;

=head1 Storedrobe::Clothing

  Storedrobe::Clothing - Main controller class

=cut

use Mojo::Base 'Mojolicious::Controller';

=head1 csv_upload

=cut

sub csv_upload {
    my $self = shift;
    my $response = {
	success => 1,
	message => "cv upload successful",
    };
    return $self->render( json => $response );
}

=head1 search

=cut

sub search {
    my $self = shift;
    my $response = {
	success => 1,
	results => [
	    "result 1",
	    "result 2",
	    "result 3"
	    ]
    };
    return $self->render( json => $response );
}

=head1 tag_search

=cut

sub tag_search {
    my $self = shift;
    my $schema = $self->app->schema;
    my $tag_data = [
	blah => 123
	];
    $schema->populate('Tag', [ $tag_data ]);

    my $response = {
	success => 1,
	tags => [
	    "tag 1",
	    "tag 2",
	    "tag 3"
	    ],
    };
    use Data::Dumper;
    return $self->render( json => Dumper($self->app->schema) );
}

1;

