#!/bin/bash

NAME="buildcss"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-07-15"
UPDATED="2018-07-15"

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main(){
  while getopts :vh option; do
    case "${option}" in
      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h) printinfo && exit ;;
      *) printinfo && ERX "not a valid command: $0 $@" ;;
    esac
  done

  (($#<1)) && ERX "no target theme"

  cssdir="$THIS_DIR"
  trgtheme="$1"
  opdir="$cssdir/css/$trgtheme"

  tsrc="$cssdir/themes/$trgtheme/theme.styl"

  [[ -f "$tsrc" ]] || ERX "no such file: $tsrc"

  mkdir -p "$opdir"

  for f in "$cssdir/sites/"*; do
    sitename="${f##*/}"
    sitename="${sitename%.*}"
    [[ $sitename =~ ^_.* ]] && continue

    stylus --include "$cssdir/styl" \
           --import "$tsrc" -p "$f" \
      > "$opdir/$sitename.css"
  done

}

printinfo(){
about='
`buildcss` - generates css files with stylus

SYNOPSIS
--------

`buildcss` [`-v`|`-h`]  
`buildcss` THEME  

DESCRIPTION
-----------

`buildcss` takes the one argument, THEME. If there
doesn'"'"'t exist a file named, themes/THEME/theme.styl.
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
Each theme have it'"'"'s own subdirectory in *css* .
The subdirectories contain css files with the same
name as the template in *sites/* that was used to 
generate it.


DEPENDENCIES
------------

stylus
'

bouthead="
${NAME^^} 1 ${CREATED} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${AUTHOR} <${CONTACT}>
<https://budrich.github.io>

SEE ALSO
--------

stylus, mondo(1)
"


  case "$1" in
    m ) printf '%s' "${about}" ;;
    
    f ) 
      printf '%s' "${bouthead}"
      printf '%s' "${about}"
      printf '%s' "${boutfoot}"
    ;;

    ''|* ) 
      printf '%s' "${about}" | awk '
         BEGIN{ind=0}
         $0~/^```/{
           if(ind!="1"){ind="1"}
           else{ind="0"}
           print ""
         }
         $0!~/^```/{
           gsub("[`*]","",$0)
           if(ind=="1"){$0="   " $0}
           print $0
         }
       '
    ;;
  esac
}

ERR(){ >&2 echo $@ ; }
ERX(){ >&2 echo $@ && exit 1 ; }

if [ "$1" = "md" ]; then
  printinfo m
  exit
elif [ "$1" = "man" ]; then
  printinfo f
  exit
else
  main "${@}"
fi
