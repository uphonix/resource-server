package ResourceServer::Schema::Result::Category;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('Category');
__PACKAGE__->add_columns(
    'category_id' => {
        data_type => 'integer',
    },
    'name' => {
        data_type => 'varchar',
        size => '50',
    }
);

__PACKAGE__->set_primary_key('category_id');
__PACKAGE__->belongs_to(
    'items' => 'ResourceServer::Schema::Result::Item',
    {'foreign.category_fk'=>'self.category_id'}
);

1;
