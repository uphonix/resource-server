package Storedrobe::Schema::Result::Tag;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('tag');
__PACKAGE__->add_columns(
    'tag_id' => {
        data_type => 'integer',
	is_nullable => 0,
	is_auto_increment => 1,
    },
    'name' => {
        data_type => 'varchar',
    });

__PACKAGE__->set_primary_key('tag_id');
__PACKAGE__->add_unique_constraint('uniq_tag_name' => [ 'name' ] );

__PACKAGE__->has_many(
    'item_tags' => 'Storedrobe::Schema::Result::ItemTag',
    {'foreign.tag_id'=>'self.tag_id'}
);

1;
