=head1 Storedrobe::Clothing

  Storedrobe::Clothing - Main controller class

=cut

package Storedrobe::Clothing;

use Mojo::Base 'Mojolicious::Controller';

=head1 csv_upload

=cut

sub csv_upload {
    my $self = shift;
    return $self->render( text => "okokok csv upload" );
}

=head1 search

=cut

sub search {
    my $self = shift;
    return $self->render( text => "search okokok" );
}

=head1 tag_search

=cut

sub tag_search {
    my $self = shift;
    return $self->render( text => "tag search ok" );
}

1;
