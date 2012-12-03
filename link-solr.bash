#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: ${0##*/} --from <confpath> --to <solrpath>"
    echo "Please enter the path to the configuration from the apachesolr module,"
    echo " followed by the path where the solr installation lies, i.e. the actual core-name/conf."
    echo "Neither path should have a trailing slash."
    exit
fi

promptyn() {
    while true; do
        read -p "$1 " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

confpath='false';
solrpath='false';

OPTS=`getopt -o s:d: -l src:,dst:,from:,to: -- "$@"`

eval set -- "$OPTS"

while true ; do
    case "$1" in
        # This is the path to the configuration from the apachesolr module,
        # e.g. '/var/www/d7_sites4dev/htdocs/sites/all/modules/contrib/apachesolr/solr-conf/solr-3.x'
        # FROM:
        -s | --src  | --from ) confpath="${2%/}"; shift; shift;;

        # This is the path where the solr installation lies, the actual core configuration
        # e.g. '/usr/local/solr/drupal/multicore/d7-bhe/conf'
        # TO:
        -d | --dst  | --to   ) solrpath="${2%/}"; shift; shift;;

        # Neither path should have a trailing slash

        --) shift; break;;
        * ) break ;;
    esac
done

if [ "$confpath" == '.' ]; then
    confpath=$(pwd);
fi

if [ "$solrpath" == '.' ]; then
    solrpath=$(pwd);
fi

if [ "$confpath" == "false" -o "$solrpath" == "false" ]; then
    echo "Usage: ${0##*/} --from <confpath> --to <solrpath>"
    echo "You must include both source and destination directories."
    exit
elif [ ! -d "$confpath" ]; then
    echo "Hmm. $confpath doesn't exist, does it?"
    echo "Try again, bub."
    exit
elif [ ! -d "$solrpath" ]; then
    echo "Waitaminute, $solrpath isn't really there."
    echo "Are you pulling my leg?"
    exit
else
    echo "You specified the configuration path to link from as:"
    echo $confpath
    echo "And the solr path to link to as:"
    echo $solrpath
    echo
    promptyn "Are you sure (Y/N)?" || exit
fi

timestamp=$(date +%s)

for file in `ls --color=never $confpath`; do
  echo
  if [ -f $solrpath/$file ]; then
      echo "Backing up $solrpath/$file"
      mv $solrpath/$file{,.$timestamp.bak} || exit
  fi
  echo "Linking $file"
  ln -s $confpath/$file $solrpath/
done

echo
echo "Please verify:"
echo ls -Al $solrpath
ls -Al --color $solrpath
