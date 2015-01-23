package Storedrobe::Clothing;

=head1 Storedrobe::Clothing

  Storedrobe::Clothing - Main controller class for /clothing route

=cut

use Mojo::Base 'Mojolicious::Controller';
use Mojo::Upload;

use Text::CSV;
use Text::Trim;

#use utf8;
=head1 csv_upload

=cut

sub csv_upload {
    my $self = shift;
    my $upload = $self->req->upload('csv_upload');
    
    my $response = { };

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

	my @rows;
	my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
	    or die "Cannot use CSV: ".Text::CSV->error_diag ();
 
	my $item_rs = $self->app->schema->resultset('Item');
	my $category_rs = $item_rs->related_resultset('category');
	open my $fh, "<:encoding(utf8)", $csv_path or die $upload->filename . ": $!";
	while ( my $row = $csv->getline( $fh ) ) {
	    #my $new_item = $item_rs->find_or_new({ name => $row->[0]});
	    #$row->[2] =~ m/pattern/ or next; # 3rd field should match
	    my $cat = $category_rs->find_or_new({ name => $row->[1] });
	    #$cat->insert();
	    my $item = $item_rs->find_or_new({ category => $cat, name => $row->[0]});
	    $item->insert();
	    push @rows, $row;
	}
	$csv->eof or $csv->error_diag();
	close $fh;





	$response = {
	    csv_upload => $upload->filename,
	    content_type => $upload->headers->content_type,
	    rows => \@rows
	}
    }

    return $self->render( json => $response, charset=> 'utf-8' );
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

=head1 tag_search

=cut

sub tag_search {
    my $self = shift;
    my $schema = $self->app->schema;
    my $tag_data = [
	blah => 123
	];
    $schema->populate('Tag', [ $tag_data ]);

    my $response = {
	success => 1,
	tags => [
	    "tag 1",
	    "tag 2",
	    "tag 3"
	    ],
    };
    return $self->render( json => $response );
}

1;

