require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :catalogue do

  desc 'This task only should be executed on a clean database.'
  task :first_import do
    puts ':: Initializing first import for BISE:Catalogue'
    puts ':: Loading basic data... '
    Rake::Task['db:seed'].execute
    Rake::Task['catalogue:import:load_repo_before'].execute
    Rake::Task['catalogue:import:countries'].execute
  end

  namespace :reindex do
    desc 'Reindex all classifiable objects (Documents, Links and Webpages)'
    task classifiable: :environment do
      puts ":: Reindexing links.."
      Link.find_each { |a| a.save! }
      puts ":: Reindexing documents.."
      Document.find_each { |a| a.save! }
      puts ":: Reindexing webpages.."
      Article.find_each { |a| a.save! }
      puts ":: Done!"
    end
  end

  namespace :import do

    # Internal task that loads common vocabularies, spira inherited classes and
    # a Virtuoso Repository to query agains
    # NOTE: Is executed before each rake task
    task :load_repo_before do
      include RDF

      puts ':: Loading...'
      RDFS99  = RDF::Vocabulary.new(
                'http://www.w3.org/1999/02/22-rdf-syntax-ns#')
      EUNIS   = RDF::Vocabulary.new(
                  'http://eunis.eea.europa.eu/rdf/schema.rdf#')
      HABITAT = RDF::Vocabulary.new(
                  'http://eunis.eea.europa.eu/rdf/habitats-schema.rdf#')
      SITE    = RDF::Vocabulary.new(
                  'http://eunis.eea.europa.eu/rdf/sites-schema.rdf#')
      TAXON   = RDF::Vocabulary.new(
                  'http://eunis.eea.europa.eu/rdf/taxonomies-schema.rdf#')
      SPECIES = RDF::Vocabulary.new(
                  'http://eunis.eea.europa.eu/rdf/species-schema.rdf#')
      @repo   = RDF::Virtuoso::Repository.new(
                  'http://semantic.eea.europa.eu/sparql')
      # Spira.add_repository(:default, @repo)
      Spira.repository = @repo

      # Loads Spira Classes to map subjects to objects
      path =  File.expand_path(File.dirname(__FILE__))
      Dir[path + '/eunis/*.rb'].each { |file| require file }

      # Default Query
      @query = RDF::Virtuoso::Query
    end


    # Loads countries with selection enabled from Semantic service
    desc 'Loads countries from EUNIS... (NOTE: Only used on first import)'
    task countries: :environment do
      q = @query.select(:country).where([:country, RDFS99.type, EUNIS.Country])
      @repo.select(q).each do |result|
        c = result[:country].as(EunisCountry)
        if c.selection == '1' && !c.isoCode2.nil?
          new_country = Country.new
          new_country.uri = c.subject.to_s
          new_country.name = c.areaName_with_locales[:en]
          new_country.code = c.eunisAreaCode
          new_country.iso_code2 = c.isoCode2
          new_country.iso_code3 = c.isoCode3
          new_country.iso_n = c.iso_n
          new_country.iso_2_wcmc = c.iso_2_wcmc
          new_country.iso_3_wcmc = c.iso_3_wcmc
          new_country.iso_3_wcmc_parent = c.iso_3_wcmc_parent
          new_country.areucd = c.areucd
          new_country.surface = c.surface
          new_country.population = c.population
          new_country.capital = c.capital
          new_country.selection = c.selection
          new_country.save
        end
      end
    end
    task countries: :load_repo_before

    # Loads biogeoregions, taxonomies, species, habitats & sites from EUNIS
    desc 'Import all from EUNIS'
    task all: :environment do
      Rake::Task['catalogue:import:biogeoregions'].execute
      Rake::Task['catalogue:import:taxonomies'].execute
      Rake::Task['catalogue:import:species'].execute
      Rake::Task['catalogue:import:habitats'].execute
      Rake::Task['catalogue:import:sites'].execute
      Rake::Task['catalogue:import:clean'].execute
    end
    task all: :load_repo_before

    # Loads biogeoregions from EUNIS
    desc 'EUNIS: Import biogeoregions'
    task biogeoregions: :environment do
      puts ':: Loading biogeoregions...'

      q = @query.select(:biogeo).where(
            [:biogeo, RDFS99.type, EUNIS.BioGeoRegion])
      @repo.select(q).each_with_index do |result, i|
        print_process(i)
        b = result[:biogeo].as(EunisBioGeoRegion)

        biogeo = BiogeoRegion.where(uri: b.subject.to_s).first_or_create
        biogeo.uri = b.subject.to_s
        biogeo.area_name = b.areaName
        biogeo.code = b.codeEEA
        biogeo.save

        b.countries.each do |c|
          country = Country.where(uri: c.subject.to_s).first
          if !country.nil? && !country.biogeo_regions.to_a.include?(biogeo)
            country.biogeo_regions.push(biogeo)
          end
        end

      end
    end
    task biogeoregions: :load_repo_before

    # Loads taxonomies from EUNIS
    desc 'EUNIS: Import taxonomies'
    task taxonomies: :environment do
      puts ':: Loading taxonomies...'

      q = @query.select(:taxonomy).where([:taxonomy, RDFS99.type, TAXON.Taxon])
      @repo.select(q).each_with_index do |result, i|
        print_process(i)
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

    # Loads species from EUNIS
    desc 'EUNIS: Import Species'
    task species: :environment do
      puts ':: Loading species...'

      q = @query.select(:species).where(
            [:species, RDFS99.type, SPECIES.SpeciesSynonym])
      @repo.select(q).each_with_index do |result, i|

        print_process(i)
        s = result[:species].as(EunisSpecies)

        species = Species.where(uri: s.subject.to_s).first_or_create
        species.uri                         = s.subject.to_s
        species.binomial_name               = s.binomialName
        unless s.eunisPrimaryName.nil?
          species.eunis_primary_name        = s.eunisPrimaryName.binomialName
        end
        species.genus                       = s.genus
        species.label                       = s.label
        species.valid_name                  = s.validName == 1 ? true : false
        species.scientific_name             = s.scientificName
        species.scientific_name_authorship  = s.scientificNameAuthorship
        species.species_code                = s.speciesCode
        unless s.speciesGroup.nil?
          species.species_group             = s.speciesGroup.commonName
        end
        unless s.synonymFor.nil?
          species.synonym_for = s.synonymFor.subject.to_s
        end
        species.taxonomic_rank              = s.taxonomicRank

        unless s.taxonomy.nil?
          t = Taxonomy.find_by_uri(s.taxonomy.to_s)
          species.taxonomy_id = t.id unless t.nil?
        end
        species.save
        s.vernacularName_with_locales.keys.each do |key|
          st = SpeciesTranslation.where(
                  species_id: species.id,
                  locale: key.to_s
               ).first_or_create
          st.locale = key.to_s
          st.name = s.vernacularName_with_locales[key]
          st.species = species
          st.save
        end

      end

    end
    task species: :load_repo_before

    desc 'EUNIS: Import habitats'
    task habitats: :environment do
      puts ':: Loading habitats...'

      q = @query.select(:habitat).where(
            [:habitat, RDFS99.type, HABITAT.HabitatType])
      results = @repo.select q

      results.each_with_index do |result, i|
        h = result[:habitat].as(EunisHabitat)
        print_process(i)

        habitat = Habitat.where(uri: h.subject.to_s).first_or_create
        habitat.uri                       = h.subject.to_s
        habitat.code                      = h.code
        habitat.natura2000_code           = h.natura2000Code
        habitat.name                      = h.name
        habitat.habitat_code              = h.habitatCode
        habitat.level                     = h.level
        habitat.originally_published_code = h.originallyPublishedCode
        habitat.description               = h.description
        habitat.comment                   = h.comment
        unless h.nationalName.nil?
          habitat.national_name             = h.nationalName_with_locales[:en]
        end
        habitat.save

        habitat.species.each do |s|
          species = Species.where(uri: s.subject.to_s).first_or_create
          unless species.nil? || species.habitats.to_a.include?(habitat)
            species.habitats << habitat
          end
        end
      end
    end
    task habitats: :load_repo_before

    # Loads sites from EUNIS
    desc 'EUNIS: Import protected sites'
    task sites: :environment do
      puts ':: Loading protected areas...'

      site_query  = @query.select(:site).where([:site, RDFS99.type, SITE.Site])
      results = @repo.select(site_query)

      results.each_with_index do |result, i|
        s = result[:site].as(EunisSite)
        print_process(i)
        pa = ProtectedArea.where(uri: s.subject.to_s).first_or_create
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

        # pa.species << Species.where(uri: s.species.map(&:subject).to_s)
        s.species.each do |x|
          species = Species.where(uri: x.subject.to_s).first
          pa.species.push(species) unless species.nil? || pa.species.exists?(species)
        end

        s.countries.each do |c|
          country = Country.where(uri: c.subject.to_s).first
          pa.countries.push(country) unless country.nil? || pa.countries.exists?(country)
        end

        s.biogeoregions.each do |b|
          biogeo = BiogeoRegion.find_by_code(b.codeEEA)
          pa.biogeo_regions.push(biogeo) unless biogeo.nil? || pa.biogeo_regions.exists?(biogeo)
        end

        s.habitats.each do |h|
          habitat = Habitat.find_by_code(h.code)
          pa.habitats.push(habitat) unless habitat.nil? || pa.habitats.exists?(habitat)
        end

      end
    end
    task sites: :load_repo_before

    # Loads sites from EUNIS
    desc 'Clean deprecated objects'
    task clean: :environment do
      puts ':: Searching deprecated species...'
      Species.all.each_with_index do |s,i|
        print_process(i)
        q  = @query.select.where([RDF::Resource.new(s.uri), :p, :o])
        results = @repo.select(q)
        unless results.size > 0
          puts ':: deleting species with uri: ' + s.uri
          s.destroy
        end
      end

      puts ':: Searching deprecated habitats...'
      Habitat.all.each_with_index do |h,i|
        print_process(i)
        q  = @query.select.where([RDF::Resource.new(h.uri), :p, :o])
        results = @repo.select(q)
        unless results.size > 0
          puts ':: deleting habitat with uri: ' + h.uri
          h.destroy
        end
      end

      puts ':: Searching deprecated protected areas...'
      ProtectedArea.all.each_with_index do |pa,i|
        print_process(i)
        q  = @query.select.where([RDF::Resource.new(pa.uri), :p, :o])
        results = @repo.select(q)
        unless results.size > 0
          puts ':: deleting protected area with uri: ' + pa.uri
          pa.destroy
        end
      end
    end
    task clean: :load_repo_before
  end


  namespace :reindex do
    desc 'Reindex documents'
    task documents: :environment do
      Document.find_each do |doc|
        begin
          puts ":: Reindexing document #{doc.title}..."
          doc.save!
        rescue Exception => e
          puts ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
          puts ":: #{e}"
          puts ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
        end
      end
    end
  end

end
