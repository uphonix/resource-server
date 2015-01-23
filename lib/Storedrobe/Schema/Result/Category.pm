package Storedrobe::Schema::Result::Category;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('category');
__PACKAGE__->add_columns(
    'category_id' => {
        data_type => 'integer',
	is_nullable => 0,
	is_auto_increment => 1,
    },
    'name' => {
        data_type => 'varchar',
        size => '50',
        extra => {
            'COLLATE' => 'utf8_bin',
        },
    },
);

__PACKAGE__->set_primary_key('category_id');
__PACKAGE__->add_unique_constraint('uniq_category' => [ 'name' ] );

__PACKAGE__->has_many(
    'items' => 'Storedrobe::Schema::Result::Item',
    {'foreign.category_id'=>'self.category_id'}
);

1;
