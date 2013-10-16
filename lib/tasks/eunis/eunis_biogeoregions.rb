require 'spira'


class EunisBioGeoRegion < Spira::Base
    EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/schema.rdf#")

    configure base_uri: "http://eunis.eea.europa.eu/biogeoregions"

    property :codeEEA           , predicate: EUNIS.codeEEA           , type: XSD.string
    property :areaName          , predicate: EUNIS.areaName          , type: Spira::Types::Any, localized: true

    has_many :countries         , predicate: EUNIS.hasCountry        , type: 'EunisCountry'

end

