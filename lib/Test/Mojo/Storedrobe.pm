package Test::Mojo::Storedrobe;

use Mojo::Base 'Test::Mojo';

use Storedrobe;

=head1 NAME

Test::Mojo::Storedrobe - subclass of Test::Mojo

=cut

sub new {
  my ($class, @params) = @_;

  $ENV{MOJO_HOME} = 't/'; # so we can load the test config

  if ( !@params ) {
      (@params) = ('Storedrobe');
  }

  my $self = $class->SUPER::new(@params);

  ## SQLite schema
  $self->app->schema->deploy();

  return $self;
}

1;
