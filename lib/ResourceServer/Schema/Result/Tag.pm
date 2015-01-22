package Storedrobe::Schema::Result::Tag;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('tag');
__PACKAGE__->add_columns(
    'tag_id' => {
        data_type => 'integer',
    },
    'name' => {
        data_type => 'varchar',
    });

__PACKAGE__->set_primary_key('tag_id');

__PACKAGE__->belongs_to(
    'item_tags' => 'Storedrobe::Schema::Result::ItemTag',
    {'foreign.tag_fk'=>'self.tag_id'}
);

1;
