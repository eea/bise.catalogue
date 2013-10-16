require 'spira'

class EunisSpeciesGroup < Spira::Base

  EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/schema.rdf#")
  configure base_uri: "http://eunis.eea.europa.eu/speciesgroup"

  property :scientificName   , predicate: EUNIS.scientific_name       , type: XSD.string

end


