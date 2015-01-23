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

On Success:
Returns JSON hash containing:
 'success' => 1,
 'message' => 'success message'

On Error:
Returns JSON hash containing:
 'error' => 'error message'

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
    return $self->render( json => $response );
}

=head1 search

=cut

sub search {
    my $self = shift;
    my $response = {
	success => 1,
	results => [
	    "result 1",
	    "result 2",
	    "result 3"
	    ]
    };
    return $self->render( json => $response );
}

=head1 tag_item

Tag an item of clothing.

POST '/clothing/item/:item_id/tag/:term'

Patams:
 :item_id - ID of the clothing item to tag
 :term    - The name of the new tag

On Success:
Returns JSON hash containing:
 'success' => 1,
 'message' => 'success message'

On Error:
Returns JSON hash containing:
 'error' => 'error message'

=cut

sub tag_item {
    my $self = shift;
    my $item_id = $self->param('item_id') or die "item_id is required";
    my $term = trim $self->param('term') or die "term is required";

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
    return $self->render( json => $response );
}

=head1 tag_search

Search for items by Tag.

POST '/clothing/tag/:term'

Patams:
 :term    - Prefix on tag to search

On Success:
Returns JSON hash containing:
 'success' => 1,
 'message' => 'success message'

On Error:
Returns JSON hash containing:
 'error' => 'error message'

=cut

sub tag_search {
    my $self = shift;
    my $term = trim $self->param('term') or die "term is required";

    my $schema = $self->app->schema;

    my $tag_rs = $schema->resultset('Tag');
    my @tags = $tag_rs->search_like({ name => "$term%" });

    my $response = {};

    if(!@tags) {
	$response = {
	    success => 1,
	    items => [],
	};	
    } else {
	$response = {
	    success => 1,
	    tags => \@tags,
	};
    }
    return $self->render( json => $response );
}

1;

