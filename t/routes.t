#!/usr/bin/env perl

use Test::More;
use Data::Dumper;

use Storedrobe;
use Test::Mojo::Storedrobe;

my $t = Test::Mojo::Storedrobe->new;

# TODO: fix sqlite schema issues
$t->post_ok('/clothing/upload-csv')->status_is(200);
$t->get_ok('/clothing/upload-csv')->status_is(404); 
$t->post_ok('/clothing/1/tag/summeroutfit')->status_is(200);
$t->get_ok('/clothing/1/tag/summeroutfit')->status_is(404);

$t->get_ok('/clothing/search/iWalk Dress Trousers')->status_is(200);
$t->get_ok('/clothing/search/tag/summeroutfit')->status_is(200);
$t->get_ok('/clothing/search/category/jumpers')->status_is(200);

done_testing();
