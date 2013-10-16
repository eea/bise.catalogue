require 'spira'

class EunisHabitat < Spira::Base
    EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/habitats-schema.rdf#")

    configure base_uri: "http://eunis.eea.europa.eu/habitats"

    property :code                      , predicate: EUNIS.code                      , type: XSD.integer
    property :natura2000Code            , predicate: EUNIS.natura2000Code            , type: XSD.integer
    property :name                      , predicate: EUNIS.name                      , type: XSD.string
    property :habitatCode               , predicate: EUNIS.habitatCode               , type: XSD.string

    property :level                     , predicate: EUNIS.level                     , type: XSD.integer
    property :originallyPublishedCode   , predicate: EUNIS.originallyPublishedCode   , type: XSD.integer

    # typicalSpecies
    property :description               , predicate: EUNIS.description               , type: XSD.string
    # hasReference
    property :comment                   , predicate: EUNIS.comment                   , type: XSD.string
    property :nationalName              , predicate: EUNIS.nationalName              , type: Spira::Types::Any, localized: true


    has_many :species                   , predicate: EUNIS.typicalSpecies            , type: 'EunisSpecies'

    # hasParent
    #hasAncestor : HabitatType

    # TODO : not implemented
    # property :sameAs                    , predicate: EUNIS.sameAs                    , type:

end
