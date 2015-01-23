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

1;
