package Storedrobe::Schema::Result::Item;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('item');
__PACKAGE__->add_columns(
    'item_id' => {
        data_type => 'integer',
    },
    'category_fk' => {
	data_type => 'integer',
    },
    'name' => {
        data_type => 'varchar',
        size => '96',
    }
);

__PACKAGE__->set_primary_key('item_id');
__PACKAGE__->has_many(
    'item_tags' => 'Storedrobe::Schema::Result::ItemTag',
    {'foreign.item_fk'=>'self.item_id'}
);
__PACKAGE__->has_one(
    'category' => 'Storedrobe::Schema::Result::Category',
    {'foreign.category_id'=>'self.category_fk'}
);

1;

