package Storedrobe::Schema::Result::Item;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('item');
__PACKAGE__->add_columns(
    'item_id' => {
        data_type => 'integer',
	is_nullable => 0,
	is_auto_increment => 1,
    },
    'category_id' => {
	data_type => 'integer',
    },
    'name' => {
        data_type => 'varchar',
        size => '96',
        extra => {
            'COLLATE' => 'utf8_bin',
        },
    },
);

__PACKAGE__->set_primary_key('item_id');
__PACKAGE__->add_unique_constraint('item_category_uniq' => [ qw/item_id category_id/ ] );

__PACKAGE__->has_many(
    'item_tags' => 'Storedrobe::Schema::Result::ItemTag',
    {'foreign.item_id'=>'self.item_id'}
);
__PACKAGE__->has_one(
    'category' => 'Storedrobe::Schema::Result::Category',
    {'foreign.category_id'=>'self.category_id'}
);

1;

