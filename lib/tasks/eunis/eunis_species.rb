require 'spira'


class EunisSpecies < Spira::Base
    EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/species-schema.rdf#")
    DWC   = RDF::Vocabulary.new("http://rs.tdwg.org/dwc/terms/")
    RDFS  = RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")

    configure base_uri: "http://eunis.eea.europa.eu/species"

    property :label                     , predicate: RDFS.label                      , type: XSD.string
    # property :nameAccordingToID         , predicate: DWC.nameAccordingToID           , type: XSD.string
    property :validName                 , predicate: EUNIS.validName                 , type: XSD.integer
    property :speciesCode               , predicate: EUNIS.speciesCode               , type: XSD.string
    property :binomialName              , predicate: EUNIS.binomialName              , type: XSD.string
    property :genus                     , predicate: DWC.genus                       , type: XSD.string
    property :vernacularName            , predicate: DWC.vernacularName              , type: Spira::Types::Any    , localized: true

    property :scientificName            , predicate: DWC.scientificName              , type: XSD.string
    property :scientificNameAuthorship  , predicate: DWC.scientificNameAuthorship    , type: XSD.string

    property :eunisPrimaryName          , predicate: EUNIS.eunisPrimaryName          , type: 'EunisSpecies'
    property :speciesGroup              , predicate: EUNIS.speciesGroup              , type: 'EunisSpeciesGroup'

    property :synonymFor                , predicate: EUNIS.synonymFor                , type: 'EunisSpecies'

    property :taxonomicRank             , predicate: EUNIS.taxonomicRank             , type: XSD.string
    property :taxonomy                  , predicate: EUNIS.taxonomy                  , type: 'EunisTaxonomy'

end
