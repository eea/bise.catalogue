#!/bin/bash

# A developer tool to reindex the ElasticSearch index

if [ -z $RAILS_ENV ]; then
	echo "Please set \$RAILS_ENV name";
	exit 1
fi

rake environment tire:import CLASS='Article' FORCE=true
rake environment tire:import CLASS='BiogeoRegion' FORCE=true
rake environment tire:import CLASS='Country' FORCE=true
rake environment tire:import CLASS='Document' FORCE=true
rake environment tire:import CLASS='Habitat' FORCE=true
rake environment tire:import CLASS='Link' FORCE=true
rake environment tire:import CLASS='News' FORCE=true
rake environment tire:import CLASS='ProtectedArea' FORCE=true
rake environment tire:import CLASS='Species' FORCE=true
