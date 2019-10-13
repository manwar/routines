package routines;

use 5.014;

use strict;
use warnings;

# VERSION

sub import {
  require Function::Parameters;

  Function::Parameters->import(
    settings(@_)
  )
}

sub settings {
  my ($class, @args) = @_;

  require registry;

  # reifier config
  my $caller = caller(1);
  my $registry = registry::access($caller);
  my $reifier = sub { $registry->lookup($_[0]) };
  my @config = $registry ? ($class, $reifier) : ($class);

  # keyword config
  my %settings;

  %settings = (func_settings(@config), %settings);
  %settings = (meth_settings(@config), %settings);
  %settings = (befr_settings(@config), %settings);
  %settings = (aftr_settings(@config), %settings);
  %settings = (arnd_settings(@config), %settings);
  %settings = (augm_settings(@config), %settings);
  %settings = (over_settings(@config), %settings);

  return {%settings};
}

sub func_settings {
  my ($class, $reifier) = @_;

  return (fun => {
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'function',
    invocant             => 1,
    name                 => 'optional',
    named_parameters     => 1,
    runtime              => 1,
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub meth_settings {
  my ($class, $reifier) = @_;

  return (method => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    invocant             => 1,
    name                 => 'optional',
    named_parameters     => 1,
    runtime              => 1,
    shift                => '$self',
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub aftr_settings {
  my ($class, $reifier) = @_;

  return (after => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    install_sub          => 'after',
    invocant             => 1,
    name                 => 'required',
    named_parameters     => 1,
    runtime              => 1,
    shift                => '$self',
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub befr_settings {
  my ($class, $reifier) = @_;

  return (before => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    install_sub          => 'before',
    invocant             => 1,
    name                 => 'required',
    named_parameters     => 1,
    runtime              => 1,
    shift                => '$self',
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub arnd_settings {
  my ($class, $reifier) = @_;

  return (around => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    install_sub          => 'around',
    invocant             => 1,
    name                 => 'required',
    named_parameters     => 1,
    runtime              => 1,
    shift                => ['$orig', '$self'],
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub augm_settings {
  my ($class, $reifier) = @_;

  return (augment => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    install_sub          => 'augment',
    invocant             => 1,
    name                 => 'required',
    named_parameters     => 1,
    runtime              => 1,
    shift                => '$self',
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

sub over_settings {
  my ($class, $reifier) = @_;

  return (override => {
    attributes           => ':method',
    check_argument_count => 0, # for backwards compat :(
    check_argument_types => 1,
    default_arguments    => 1,
    defaults             => 'method',
    install_sub          => 'override',
    invocant             => 1,
    name                 => 'required',
    named_parameters     => 1,
    runtime              => 1,
    shift                => '$self',
    types                => 1,

    # include reifier or fallback to function-based
    ($reifier ? (reify_type => $reifier) : ())
  });
}

1;
