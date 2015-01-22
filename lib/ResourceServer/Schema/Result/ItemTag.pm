package ResourceServer::Schema::Result::ItemTag;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('item_tag');
__PACKAGE__->add_columns(
    'item_tag_id' => {
        data_type => 'integer',
    },
    'item_fk' => {
	data_type => 'integer',
    },
    'tag_fk' => {
	data_type => 'integer',
    }
);

__PACKAGE__->set_primary_key('item_tag_id');

__PACKAGE__->belongs_to(
    'item' => 'ResourceServer::Schema::Result::Item',
    {'foreign.item_id'=>'self.item_fk'}
);
__PACKAGE__->has_one(
    'tag' => 'ResourceServer::Schema::Result::Tag',
    {'foreign.tag_id'=>'self.tag_fk'}
);

1;

