#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 --from <confpath> --to <solrpath>"
    echo "Please enter the path to the configuration from the apachesolr module,"
    echo " followed by the path where the solr installation lies, i.e. the actual core-name/conf."
    echo "Neither path should have a trailing slash."
    exit
fi

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

if [ ! -d $confpath -o "$confpath" == "false" -o ! -d $solrpath -o "$solrpath" == "false" ]; then
    echo "Usage: $0 --from <confpath> --to <solrpath>"
    echo "Please enter a valid directory path for both arguments."
    echo "Neither path should have a trailing slash."
    exit
fi

timestamp=$(date +%s)

for file in `ls --color=never $confpath`; do
  echo
  echo "Backing up $solrpath/$file"
  mv $solrpath/$file{,.$timestamp.bak} || exit
  echo "Linking $file"
  ln -s $confpath/$file $solrpath/
done

echo
echo "Please verify:"
echo ls -Al $solrpath
ls -Al --color $solrpath
