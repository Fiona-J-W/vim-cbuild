# vim-cbuild

A small plugin to call cmake from vim. For this it searches
through all parent-folders and searches for one that is named
`build`. In that a subdirectory will be choosen by the user in
which `cmake ../..` and `ninja`/`make` are called.

It is the users task to make sure that the sub-directory exists
and that it already contains the desired cmake-configuration.

This plugin will decide whether to call ninja or make based on
whether the build-directory contains a readable file named
`build.ninja`. If none such file exists, `make` will be used.

*WARNING* This plugin is still in alpha-phase which mainly means that I am
still experimenting regarding what the best way to implement this is.
Expect unanounced breaking changes both regarding configuration-options
and runtime-behavior.

Commands
--------

```
cbuild [build_type] [build command]
```

Variables
---------

At this time cbuild only provides one variable:

```
let g:cbuild_default_build_type=""
```


It identifies the subdirectory of the build-directory
that will be used to build the project.

If it isn't set, the default will be `"debug"`.

