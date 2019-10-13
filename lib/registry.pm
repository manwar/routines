package registry;

use 5.014;

use strict;
use warnings;

use base 'Exporter';

# VERSION

our @EXPORT = '$registry';

state %registries;

sub access {
  my ($class) = @_;

  $class ||= 'main';

  return $registries{$class};
}

sub lookup {
  my ($expr, $class) = @_;

  my $registry = access($class) or return;

  return $registry->lookup($expr);
}

sub import {
  my ($package, $library) = @_;

  my $caller = caller(0);

  require Type::Registry;

  my $object = $registries{$caller} ||= Type::Registry->for_class($caller);

  $library ||= 'Types::Standard';

  $object->add_types($library);

  return $package->export_to_level(1, $package);
}

our $registry = __PACKAGE__->can('access');

1;
