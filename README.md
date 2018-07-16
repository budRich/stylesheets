I use [stylus](http://stylus-lang.com/) to generate css userstyles. The generated css files will get placed in `css/THEME/*.css` The themes are [generated](https://github.com/budlabs/mondo-config/tree/master/generator/css) with [mondo](https://github.com/budlabs/mondo). When **mondo** applies a theme, it will symlink the directory containing the themes to `~/.config/pendactyl/plugins/css` and reload pentadactyl (*pale moon*).

---

`buildcss.sh` - generates css files with stylus

SYNOPSIS
--------

`buildcss` [`-v`|`-h`]  
`buildcss` THEME  

DESCRIPTION
-----------

`buildcss` takes the one argument, THEME. If there
doesn't exist a file named, themes/THEME/theme.styl.
The script will exit, otherwise it will use that file
to generate css files described in the *sites* directory.

OPTIONS
-------

`-v`  
Show version and exit.  

`-h`  
Show help and exit.  

FILES
-----

*themes/*  
Contains theme files (*theme.styl*) that are stored
in subdirectories with the name of the theme.

*styl/*  
`stylus` styl files in this direcotory will be available for
styl files in the *sites* directory.

*sites/*  
`stylus` template files are stored in this directory.
When `buildcss.sh` generates css files the new files
will have the same name as the files in the *sites*
directory.  

*css/*  
Each theme have it's own subdirectory in *css* .
The subdirectories contain css files with the same
name as the template in *sites/* that was used to 
generate it.


DEPENDENCIES
------------

stylus
