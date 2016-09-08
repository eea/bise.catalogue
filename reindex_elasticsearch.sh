#!/bin/bash

# A developer tool to reindex the ElasticSearch index

if [ -z $RAILS_ENV ]; then
	echo "Please set \$RAILS_ENV name";
	exit 1
fi

rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Article' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='BiogeoRegion' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Country' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Document' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Habitat' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Link' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='News' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='ProtectedArea' FORCE=true
rake environment tire:import PARAMS='{:per_page => 10}' CLASS='Species' FORCE=true
