#!/usr/bin/env perl

use Test::More;
use Data::Dumper;

use Storedrobe;
use Test::Mojo;

# my $t = Test::Mojo->new('MyApp');

# # HTML/XML
# $t->get_ok('/welcome')->status_is(200)->text_is('div#message' => 'Hello!');

# # JSON
# $t->post_ok('/search.json' => form => {q => 'Perl'})
#   ->status_is(200)
#   ->header_is('Server' => 'Mojolicious (Perl)')
#   ->header_isnt('X-Bender' => 'Bite my shiny metal ass!')
#   ->json_is('/results/4/title' => 'Perl rocks!')
#   ->json_like('/results/7/title' => qr/Perl/);

# BEGIN {
#     use_ok 'Storedrobe::Schema';
# }

# my $schema = Storedrobe::Schema->connect();

my $t = Test::Mojo->new('Storedrobe');
$t->post_ok('/clothing/upload-csv')->status_is(200);
$t->get_ok('/clothing/upload-csv')->status_is(404); 
$t->post_ok('/clothing/search/jacket')->status_is(200);
$t->get_ok('/clothing/search/jumper')->status_is(200); 
$t->get_ok('/clothing/tag/winteroutfit')->status_is(200);

#can_ok($schema, qw(init_routes));
done_testing();
