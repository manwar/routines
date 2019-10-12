# NAME

routines

# ABSTRACT

Typeable Method and Function Signatures

# SYNOPSIS

    package main;

    use strict;
    use warnings;
    use routines;

    fun hello($name) {
      "hello, $name"
    }

    hello("world");

# DESCRIPTION

This pragma is used to provide typeable method and function signtures to the
calling package, as well as `before`, `after`, and `around` method
modifiers. Additionally, when used in concert with the [registry](https://metacpan.org/pod/registry) pragma, this
pragma will check to determine whether a [Type::Tiny](https://metacpan.org/pod/Type::Tiny) registry object is
associated with the calling package, and if so will use it to reify type
constraints and resolve type expressions.

    package main;

    use strict;
    use warnings;

    use registry;
    use routines;

    fun hello(Str $name) {
      "hello, $name"
    }

    hello("world");

Additionally, when used in concert with the [registry](https://metacpan.org/pod/registry) pragma this pragma will
check to determine whether a [Type::Tiny](https://metacpan.org/pod/Type::Tiny) registry object is associated with
the calling package, and if so will use it to reify type constraints and
resolve type expressions.

    package Example;

    use Moo;
    use registry;
    use routines;

    fun new($class) {
      bless {}
    }

    method hello(Str $name) {
      "hello, $name"
    }

    around hello(Str $name) {
      $self->{name} = $name;

      $self->$orig($name);
    }

    1;

As mentioned previously, this pragma makes the `before`, `after`, and
`around` method modifiers available the calling package where those keywords
were already present in their generic subroutine form.

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/routines/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/routines/wiki)

[Project](https://github.com/iamalnewkirk/routines)

[Initiatives](https://github.com/iamalnewkirk/routines/projects)

[Milestones](https://github.com/iamalnewkirk/routines/milestones)

[Contributing](https://github.com/iamalnewkirk/routines/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/routines/issues)
