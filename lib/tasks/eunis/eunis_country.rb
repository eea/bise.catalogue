require 'spira'


class EunisCountry < Spira::Base
    EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/schema.rdf#")

    configure base_uri: "http://eunis.eea.europa.eu/countries"

    property :eunisAreaCode     , predicate: EUNIS.eunisAreaCode     , type: XSD.string
    property :areaName          , predicate: EUNIS.areaName          , type: Spira::Types::Any, localized: true

    property :isoCode2          , predicate: EUNIS.isoCode2          , type: XSD.string
    property :isoCode3          , predicate: EUNIS.isoCode3          , type: XSD.string
    property :iso_n             , predicate: EUNIS.iso_n             , type: XSD.integer
    property :iso_2_wcmc        , predicate: EUNIS.iso_2_wcmc        , type: XSD.string
    property :iso_3_wcmc        , predicate: EUNIS.iso_3_wcmc        , type: XSD.string
    property :iso_3_wcmc_parent , predicate: EUNIS.iso_3_wcmc_parent , type: XSD.string

    property :areucd            , predicate: EUNIS.areucd            , type: XSD.string
    property :surface           , predicate: EUNIS.surface           , type: XSD.integer
    property :population        , predicate: EUNIS.population        , type: XSD.integer
    property :capital           , predicate: EUNIS.capital           , type: XSD.string

    property :selection         , predicate: EUNIS.selection         , type: XSD.string
end

