package Storedrobe::Clothing;

=head1 Storedrobe::Clothing

  Storedrobe::Clothing - Main controller class for /clothing route

=cut

use Mojo::Base 'Mojolicious::Controller';
use Mojo::Upload;

use Text::CSV;
use Text::Trim;

=head1 csv_upload

Upload a CSV file.

Requires POST param 'csv_upload' - Field holding the uploaded CSV file

POST '/clothing/upload-csv'

Returns JSON hash:

=cut

sub csv_upload {
    my $self = shift;
    my $upload = $self->req->upload('csv_upload'); # upload request param
    
    my $response;

    if(!$upload->size) {
	$response = {
	    error => "no file uploaded",
	};
    } elsif($upload->headers->content_type ne "text/csv") {
	$response = {
	    error => "invalid file type uploaded",
	};
    } else {
	my $csv_path = '/tmp/'.$upload->filename;
	$upload->move_to($csv_path);

	my $csv = Text::CSV->new ( { binary => 1 } )
	              or die "Cannot use CSV: " . Text::CSV->error_diag();
 
	my $item_rs = $self->app->schema->resultset('Item');
	my $category_rs = $item_rs->related_resultset('category');
	
	open my $fh, "<:encoding(utf8)", $csv_path or die $upload->filename . ": $!";

	while ( my $row = $csv->getline( $fh ) ) {
	    my $cat = $category_rs->find_or_new({ name => trim $row->[1] });
	    my $item = $item_rs->find_or_new({ category => $cat, name => trim $row->[0]});
	    $item->insert();
	}

	$csv->eof or $csv->error_diag();
	close $fh;

	$response = {
	    message => sprintf("%s uploaded successfully", $upload->filename),
	    success => 1,
	};
    }
    return $self->_json_response($response);
}

=head1 tag_item

Tag an item of clothing.

POST '/clothing/:item_id/tag/:term'

Params:
  :item_id - ID of the clothing item to tag
  :term    - The name of the new tag

Returns JSON hash:

=cut

sub tag_item {
    my $self = shift;
    my $item_id = $self->param('item_id') or $self->_json_response({ error => "item_id is required" });
    my $term = trim $self->param('term') or $self->_json_response({ error => "term is required" });

    my $schema = $self->app->schema;
    my $item_rs = $schema->resultset('Item');

    my $item = $item_rs->find($item_id);
    
    my $response = {};
    if(!$item) {
	$response = {
	    error => "Invalid item_id: $item_id"
	};
    } else {
	my $tag_rs = $schema->resultset('Tag');
	my $tag = $tag_rs->find_or_new({ name => trim $term });

	my $item_tag_rs = $schema->resultset('ItemTag');
	my $item_tag = $item_tag_rs->find_or_new({ item => $item, tag => $tag });

	$item_tag->insert();

	$response = {
	    success => 1,
	    message => sprintf("%s tagged", $item->name()),
	};
    }
    return $self->_json_response($response);
}

=head1 search

Search for items by name.

Dies when required params are not supplied.

GET '/clothing/search/:term'

Params:
  :term    - (Required) Name of clothing item to search for

Returns JSON hash:

=cut

sub search {
    my $self = shift;
    my $term = trim $self->param('term') or return $self->_json_response({ error => "term is required" });

    my $schema = $self->app->schema;
    my $item_rs = $schema->resultset('Item');

    my @items = $item_rs->search({ name => {-like => "%$term%"} });

    return $self->_json_response({
	success => 1,
	items => [ map {
	    +{
		id => $_->id,
		name => $_->name,
		category => $_->category->name,
		tags => [ map { $_->tag->name } $_->item_tags ]
	    }
	} @items ],
    });
}

=head1 tag_search

Search for items by Tag.

Dies when required params are not supplied.

GET '/clothing/search/tag/:term'

Params:
  :term    - (Required) Prefix on tag to search

Returns JSON hash:

=cut

sub tag_search {
    my $self = shift;
    my $term = trim $self->param('term') or return $self->_json_response({ error => "term is required" });

    my $schema = $self->app->schema;
    my $tag_rs = $schema->resultset('Tag');

    my @tags = $tag_rs->search_like({ name => {-like =>"$term%"} });

    return $self->_json_response({
	success => 1,
	items => [ map {
	    map { +{
		id => $_->id,
		name => $_->item->name,
		category => $_->item->category->name,
		tags => [ map { $_->tag->name } $_->item->item_tags ],
	    } } $_->item_tags
	} @tags ]
    });
}


=head1 category_search

Search for items by Category.

Dies when required params are not supplied.

GET '/clothing/search/category/:term'

Params:
  :term    - (Required) Category 'name' to find (exact match)

Returns JSON hash:

=cut

sub category_search {
    my $self = shift;
    my $term = trim $self->param('term') or return $self->_json_response({ error => "term is required" });

    my $schema = $self->app->schema;
    my $category_rs = $schema->resultset('Category');

    my $category = $category_rs->find({ name => $term });

    return $self->_json_response({
	success => 1,
	items => [ map {
	    +{
		id => $_->id,
		name => $_->name,
		category => $_->category->name,
		tags => [ map { $_->tag->name } $_->item_tags ],
	    }
	} $category->items ]
    });
}

# shortcut to return json error
sub _json_response { $_[0]->render( json => shift ) }

1;

