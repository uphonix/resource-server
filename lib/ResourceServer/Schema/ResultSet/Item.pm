package ResourceServer::Schema::ResultSet::Item;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

sub active {
    my $self = shift;
    $self->search({ $self->current_source_alias . '.active' => 1 });
}
 
sub unverified {
    my $self = shift;
    $self->search({ $self->current_source_alias . '.verified' => 0 });
}

1;

