link-solr
=========

Sometimes the apachesolr modules solr configuration changes. This will re-link the config.

Usage
-----

<pre>link-solr.bash --from [confpath] --to [solrpath]</pre>

Where [confpath] is the path to the folder containing configuration to inject into the solr core,
and [solrpath] is the path to the solr core conf folder.

Either path (but not both) can be represented by a '.', if run from the appropriate folder,
and the full path will be substituted.

This works best with the latest version of apachesolr module for Drupal 7.

In Drupal, with the apachesolr module, the path to the solr configuration has changed over time:
7.x-1.x branch
7.x-1.1: apachesolr/solr-conf/{solr-1.4,solr-3.x}/{protwords.txt,schema.xml,solrconfig.xml}
7.x-1.0-beta14->1.0: apachesolr/solr-conf/{protwords.txt,schema{-solr3x}.xml,solrconfig{-solr3x}.xml}
7.x-1.0-beta9->beta13: apachesolr/solr-conf/{protwords.txt,schema{-solr3x}.xml,solrconfig.xml}
7.x-1.0-beta4->beta8: apachesolr/{protwords.txt,schema.xml,solrconfig.xml}
7.x-1.0-unstable1->beta3: apachesolr/{schema.xml,solrconfig.xml}

6.x-3.x branch
6.x-3.0-rc1: apachesolr/solr-conf/{solr-1.4,solr-3.x}/{protwords.txt,schema.xml,solrconfig.xml}
6.x-3.0-alpha1->beta3: apachesolr/solr-conf/{protwords.txt,schema{-solr3x}.xml,solrconfig{-solr3x}.xml}

6.x-2.x branch
6.x-2.0-beta4->beta5: apachesolr/{protwords.txt,schema.xml,solrconfig.xml}
6.x-2.0-alpha1->beta3: apachesolr/{schema.xml,solrconfig.xml}

6.x-1.x branch
6.x-1.3->1.7: apachesolr/{protwords.txt,schema.xml,solrconfig.xml}
6.x-1.0-alpha4->1.2: apachesolr/{schema.xml,solrconfig.xml}
6.x-1.0-alpha1->alpha3: apachesolr/{schema.xml}