package Storedrobe::Schema;

=head1 Storedrobe::Schema

Main Storedrobe 'DBIx::Class::Schema' class

=cut

use strict;
use warnings;

use base 'DBIx::Class::Schema';

our $VERSION = 1;

__PACKAGE__->load_namespaces;

1;
