package Storedrobe::Schema::Result::ItemTag;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('item_tag');
__PACKAGE__->add_columns(
    'item_tag_id' => {
        data_type => 'integer',
	is_nullable => 0,
	is_auto_increment => 1,
    },
    'item_id' => {
	data_type => 'integer',
	is_nullable => 0,
    },
    'tag_id' => {
	data_type => 'integer',
	is_nullable => 0,
    }
);

__PACKAGE__->set_primary_key('item_tag_id');
__PACKAGE__->add_unique_constraint('item_tag_uniq' => [ qw/item_id tag_id/ ] );

__PACKAGE__->belongs_to(
    'item' => 'Storedrobe::Schema::Result::Item',
    {'foreign.item_id'=>'self.item_id'}
);
__PACKAGE__->has_one(
    'tag' => 'Storedrobe::Schema::Result::Tag',
    {'foreign.tag_id'=>'self.tag_id'}
);

1;
