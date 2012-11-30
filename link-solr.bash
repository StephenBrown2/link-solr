#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Required arguments: 2, Entered arguments: $#"
    echo "Please enter the path to the configuration from the apachesolr module,"
    echo " followed by the path where the solr installation lies, i.e. the actual core-name/conf."
    echo "Neither path should have a trailing slash."
    exit
fi

# This is the path to the configuration from the apachesolr module,
# e.g. '/var/www/d7_sites4dev/htdocs/sites/all/modules/contrib/apachesolr/solr-conf/solr-3.x'
# FROM:
confpath=$1

if [ $confpath == '.' ]; then
    confpath=$(pwd);
fi

# This is the path where the solr installation lies, the actual core configuration
# TO:
solrpath=$2

# Neither path should have a trailing slash

timestamp=$(date +%s)

for file in `ls --color=never $confpath`; do
  echo
  echo "Backing up $solrpath/$file"
  mv $solrpath/$file{,.$timestamp.bak}
  echo "Linking $file"
  ln -s $confpath/$file $solrpath/
done

echo
echo "Please verify:"
echo ls -Al $solrpath
ls -Al --color $solrpath
