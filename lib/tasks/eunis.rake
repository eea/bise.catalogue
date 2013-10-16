require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :eunis do
  namespace :import do

    task :load_repo_before do
      include RDF

      puts ':: Loading vocabularies...'
      RDFS99 = RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
      EUNIS = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/schema.rdf#")
      HABITAT = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/habitats-schema.rdf#")
      SITE = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/sites-schema.rdf#")
      TAXON = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/taxonomies-schema.rdf#")
      SPECIES = RDF::Vocabulary.new("http://eunis.eea.europa.eu/rdf/species-schema.rdf#")

      puts ':: Loading semantic repository...'
      @repo = RDF::Virtuoso::Repository.new('http://semantic.eea.europa.eu/sparql')
      Spira.add_repository(:default, @repo)

      # Load Eunis Objects to map subjects to objects
      path =  File.expand_path(File.dirname(__FILE__))
      Dir[path + "/eunis/*.rb"].each { |file| require file }

      # Default Query
      @query = RDF::Virtuoso::Query
    end

    # --------------------------------------------------------------------------

    # TODO: Develop rake task to import all eunis
    desc 'Import Species, Habitats and Sites from EUNIS'
    task all: :environment do
      # Rake::Task["countries"].execute
      Rake::Task["eunis:import:biogeoregions"].execute
      Rake::Task["eunis:import:taxonomies"].execute
      Rake::Task["eunis:import:species"].execute
      Rake::Task["eunis:import:habitats"].execute
      Rake::Task["eunis:import:sites"].execute
    end
    task all: :load_repo_before

    # --------------------------------------------------------------------------

    # TODO: Import eunis countries
    desc 'EUNIS: Import countries (Only first time)'
    task countries: :environment do
      puts ':: Loading countries...'
    end
    task countries: :load_repo_before

    # --------------------------------------------------------------------------

    desc 'EUNIS: Import biogeoregions'
    task biogeoregions: :environment do
      puts ':: Loading biogeoregions...'

      q = @query.select(:biogeo).where([:biogeo, RDFS99.type, EUNIS.BioGeoRegion])
      @repo.select(q).each_with_index do |result,i|

        ApplicationHelper::print_process(i)
        b = result[:biogeo].as(EunisBioGeoRegion)

        biogeo = BiogeoRegion.exists?(uri: b.subject.to_s) ? BiogeoRegion.find_by_uri(b.subject.to_s) : BiogeoRegion.new
        biogeo.uri = b.subject.to_s
        biogeo.area_name = b.areaName
        biogeo.code = b.codeEEA
        biogeo.save

        for c in b.countries
          country = Country.find_by_code(c.eunisAreaCode)
          if !country.nil? && !country.biogeo_regions.nil? && !country.biogeo_regions.to_a.include?(biogeo)
            # unless country.nil? && country.biogeo_regions.nil? && country.biogeo_regions.to_a.includes?(biogeo)
            country.biogeo_regions << biogeo
          end
        end

      end
    end
    task biogeoregions: :load_repo_before

    # --------------------------------------------------------------------------

    desc 'EUNIS: Import taxonomies'
    task taxonomies: :environment do
      puts ':: Loading taxonomies...'

      q = @query.select(:taxonomy).where([:taxonomy, RDFS99.type, TAXON.Taxon])
      @repo.select(q).each_with_index do |result,i|

        ApplicationHelper::print_process(i)
        t = result[:taxonomy].as(EunisTaxonomy)

        taxonomy = Taxonomy.where(uri: t.subject.to_s).first_or_create
        taxonomy.uri = t.subject.to_s
        taxonomy.code = t.code
        taxonomy.name = t.name
        taxonomy.level = t.level
        taxonomy.parent_id = t.parent.code
        taxonomy.save

      end
    end
    task taxonomies: :load_repo_before

    # --------------------------------------------------------------------------

    # TODO: Develop rake task to import species
    desc 'Import Species from EUNIS'
    task species: :environment do

      q = @query.select(:species).where([:species, RDFS99.type, SPECIES.SpeciesSynonym])
      @repo.select(q).each_with_index do |result,i|

        ApplicationHelper::print_process(i)
        s = result[:species].as(EunisSpecies)

        species = Species.where(uri: s.subject.to_s).first_or_create
        species.uri                         = s.subject.to_s
        species.binomial_name               = s.binomialName
        species.eunis_primary_name          = s.eunisPrimaryName.binomialName unless s.eunisPrimaryName.nil?
        species.genus                       = s.genus
        # species.ignore_on_match
        species.label                       = s.label
        species.valid_name                  = s.validName == 1 ? true : false
        # species.name_according_to_ID        = s.nameAccordingToID.to_s
        species.scientific_name             = s.scientificName
        species.scientific_name_authorship  = s.scientificNameAuthorship
        species.species_code                = s.speciesCode
        species.species_group               = s.speciesGroup.scientificName unless s.speciesGroup.nil?
        species.synonym_for                 = s.synonymFor.subject.to_s unless s.synonymFor.nil?
        species.taxonomic_rank              = s.taxonomicRank

        unless s.taxonomy.nil?
          species.taxonomy_id                 = Taxonomy.find_by_code(s.taxonomy.code).id
        end
        species.save

        for key in s.vernacularName_with_locales.keys
          # TODO: Check if vernacular name already exists

          st = SpeciesTranslation.where(species_id: species.id, locale: key.to_s).first_or_create
          st.locale = key.to_s
          st.name = s.vernacularName_with_locales[key]
          st.species = species
          st.save
        end

      end

    end
    task species: :load_repo_before

    # --------------------------------------------------------------------------

    desc 'EUNIS: Import habitats'
    task habitats: :environment do
      puts ":: Syncing habitats from virtuoso..."

      q = @query.select(:habitat).where([:habitat, RDFS99.type, HABITAT.HabitatType])
      results = @repo.select q

      results.each_with_index do |result, i|
        h = result[:habitat].as(EunisHabitat)

        ApplicationHelper::print_process(i)

        habitat = Habitat.exists?(uri: h.subject.to_s) ? Habitat.find_by_uri(h.subject.to_s) : Habitat.new
        habitat.uri                       = h.subject.to_s
        habitat.code                      = h.code
        habitat.natura2000_code           = h.natura2000Code
        habitat.name                      = h.name
        habitat.habitat_code              = h.habitatCode
        habitat.level                     = h.level
        habitat.originally_published_code = h.originallyPublishedCode
        habitat.description               = h.description
        habitat.comment                   = h.comment
        habitat.national_name             = h.nationalName_with_locales[:en] unless h.nationalName.nil?
        habitat.save

        # TODO: Load species for each habitat
        for s in habitat.species
          species = Species.find_by_species_code(s.speciesCode)
          unless species.nil? && species.habitats.includes?(habitat)
            species.habitats << habitat
          end
        end
      end
    end
    task habitats: :load_repo_before

    # --------------------------------------------------------------------------

    # TODO: Develop rake task to import sites
    desc 'Import Sites from EUNIS'
    task sites: :environment do
      puts ':: Loading protected areas...'

      site_query  = QUERY.select(:site).where([:site, RDFS99.type, SITE.Site])
      results = @repo.select(site_query)

      results.each_with_index do |result,i|

        ApplicationHelper::print_process(i)
        s = result[:site].as(EunisSite)

        unless s.nil? # or s.name.nil? or ProtectedArea.exists?({code: s.id})
          print "."

          pa = ProtectedArea.new
          pa.uri                  = s.subject.to_s
          pa.code                 = s.id
          pa.name                 = s.name unless s.name.nil?
          pa.iucnat               = s.iucnat
          pa.designation_year     = s.designationDate
          pa.nuts_code            = s.nutsCode
          pa.area                 = s.area
          pa.length               = s.length
          pa.long                 = s.long
          pa.lat                  = s.lat
          pa.source_db            = s.sourceDb
          pa.save

          for x in s.species
            print 's'
            species = Species.find_by_species_code(x.speciesCode)
            species.protected_areas << pa unless species.nil?
          end

          begin
            for c in s.countries
              print 'c'
              country = Country.find_by_code(c.eunisAreaCode)
              country.protected_areas << pa unless country.nil? or country.name.nil?
            end
          rescue Exception => e
            puts ":: COUNTRY => #{e.message}"
          end

          for b in s.biogeoregions
            print 'b'
            biogeo = BiogeoRegion.find_by_code(b.codeEEA)
            biogeo.protected_areas << pa unless biogeo.nil? or biogeo.area_name.nil?
          end

          for h in s.habitats
            print 'h'
            habitat = Habitat.find_by_code(h.code)
            habitat.protected_areas << pa unless habitat.nil? or habitat.code.nil?
          end
        else
          print 'F'
        end

      end
    end

    # --------------------------------------------------------------------------

  end
end

