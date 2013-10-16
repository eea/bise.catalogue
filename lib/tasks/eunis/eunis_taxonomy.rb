require 'spira'


class EunisTaxonomy < Spira::Base

  EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/taxonomies-schema.rdf#")
  configure base_uri: "http://eunis.eea.europa.eu/taxonomy"

  property :code              , predicate: EUNIS.code       , type: XSD.integer
  # ( Kingdom, Phylum, Class, Order, Family, Genus )
  property :level             , predicate: EUNIS.level      , type: XSD.string
  property :name              , predicate: EUNIS.name       , type: XSD.string

  property :parent            , predicate: EUNIS.parent     , type: 'EunisTaxonomy'

end
