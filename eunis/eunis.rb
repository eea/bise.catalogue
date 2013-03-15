# Created by **Jon Arrien**

# * jonarrien@gmail.com
# * @jonarrien

# require 'rdf'
require 'rdf/raptor'
require 'pry'
require 'pry-nav'

include RDF



### Load Rails ENV
puts ':: Loading RAILS_ENV development'
ENV['RAILS_ENV'] = 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")





# http://rdf.rubyforge.org/doap.nt
# http://eunis.eea.europa.eu/rdf/species-schema.rdf
# http://eunis.eea.europa.eu/rdf/species.rdf.gz





# -------------------- OK ---------------------


i = 0

puts ":: Parsing RDF with Raptor v#{RDF::Raptor.version}" if RDF::Raptor.available?

# RDF::Format.for(:rdfxml)
# RDF::Format.for("species.rdf")
# RDF::Format.for(:file_name      => "species.rdf")
# RDF::Format.for(:file_extension => "rdf")
# RDF::Format.for(:content_type   => "application/rdf+xml")

puts ":: Starting process..."

RDF::Reader.open("species.rdf") do |reader|

    subject = nil
    s = nil
    i = 0

    reader.each_statement do |statement|

        i+=1

        triple = statement.to_a

        if subject != triple[0].to_s
            puts triple[0].to_s
            s = Species.new
        end

        if triple[1].to_s.include? 'speciesCode'
            # puts ":: speciesCode            =>       #{triple[2]}"
            s.species_code = triple[2].to_s
        elsif triple[1].to_s.include? 'binomialName'
            # puts ":: binomialName           =>       #{triple[2]}"
            s.binomial_name = triple[2].to_s
        elsif triple[1].to_s.include? 'validName'
            # puts ":: validName              =>       #{triple[2]}"
            s.valid_name = triple[2].to_s
        elsif triple[1].to_s.include? 'eunisPrimaryName'
            # puts ":: eunisPrimaryName       =>       #{triple[2]}"
            s.eunis_primary_name = triple[2].to_s
        elsif triple[1].to_s.include? 'synonymFor'
            # puts ":: synonymFor             =>       #{triple[2]}"
            s.synonym_for = triple[2].to_s
        elsif triple[1].to_s.include? 'taxonomicRank'
            # puts ":: taxonomicRank          =>       #{triple[2]}"
            s.taxonomic_rank = triple[2].to_s
        elsif triple[1].to_s.include? 'taxonomy'
            # puts ":: taxonomy               =>       #{triple[2]}"
            s.taxonomy = triple[2].to_s
        elsif triple[1].to_s.include? 'scientificNameAuthorship'
            # puts "::scientificNameAuthorship=>       #{triple[2]}"
            s.scientific_name_authorship = triple[2].to_s
        elsif triple[1].to_s.include? 'scientificName'
            # puts ":: scientificName         =>       #{triple[2]}"
            s.scientific_name = triple[2].to_s
        elsif triple[1].to_s.include? 'genus'
            # puts ":: genus                  =>       #{triple[2]}"
            s.genus = triple[2].to_s
        elsif triple[1].to_s.include? 'speciesGroup'
            # puts ":: speciesGroup           =>       #{triple[2]}"
            s.species_group = triple[2].to_s
        elsif triple[1].to_s.include? 'nameAccordingToID'
            # puts ":: nameAccordingToID      =>       #{triple[2]}"
            s.name_according_to_ID = triple[2].to_s
        elsif triple[1].to_s.include? 'ignoreOnNameMatch'
            # puts ":: ignoreOnNameMatch      =>       #{triple[2]}"
            s.ignore_on_match = triple[2].to_s
        end

        s.save
        subject = triple[0].to_s

        break if i > 50
    end
end

