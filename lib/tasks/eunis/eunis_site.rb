require 'spira'


class EunisSite < Spira::Base
    EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/sites-schema.rdf#")
    GEO = RDF::Vocabulary.new("http://www.w3.org/2003/01/geo/wgs84_pos#")
    XMLS = RDF::Vocabulary.new("http://www.w3.org/2001/XMLSchema#")

    configure base_uri: "http://eunis.eea.europa.eu/sites"

    property :id                , predicate: EUNIS.idSite            , type: XSD.string

    property :name              , predicate: EUNIS.name              , type: XSD.string
    property :iucnat            , predicate: EUNIS.iucnat            , type: XSD.string

    # TODO: Add designations relation
    # <hasDesignation rdf:resource="designations/167:MK98"/>
    property :designationDate   , predicate: EUNIS.designationDate   , type: XSD.string

    property :nutsCode          , predicate: EUNIS.nutsCode          , type: XSD.string
    property :area              , predicate: EUNIS.area              , type: XMLS.double
    property :length            , predicate: EUNIS.length            , type: XMLS.double

    property :altMean           , predicate: EUNIS.altMean           , type: XSD.float
    property :altMin            , predicate: EUNIS.altMin            , type: XSD.float
    property :altMax            , predicate: EUNIS.altMax            , type: XSD.float

    property :long              , predicate: GEO.long                , type: XMLS.double
    property :lat               , predicate: GEO.lat                 , type: XMLS.double

    property :sourceDb          , predicate: EUNIS.sourceDb          , type: XSD.string

    # TODO : Need to be migrated in db
    # property :respondent        , predicate: EUNIS.respondent        , type: XSD.string

    has_many :countries         , predicate: EUNIS.inCountry         , type: 'EunisCountry'
    has_many :species           , predicate: EUNIS.hasSpecies        , type: 'EunisSpecies'
    has_many :biogeoregions     , predicate: EUNIS.hasBioGeoRegion   , type: 'EunisBioGeoRegion'
    has_many :habitats          , predicate: EUNIS.hasHabitatType    , type: 'EunisHabitat'

end

