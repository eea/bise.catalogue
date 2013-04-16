$:.unshift File.dirname(__FILE__) + "/../lib/"

require 'rdf'
require 'rdf/do'
require 'rdf/spec/repository'

require 'do_postgres'

describe RDF::DataObjects::Repository do
    context "The PostgreSQL adapter" do

        before :each do
          @repository = RDF::DataObjects::Repository.new "postgres://catalogue_usr:saretex1@192.168.1.225:5432/dataobjects"
        end

        after :each do
            # DataObjects::Sqlite3::Connection.__pools.clear
            DataObjects::Postgresql::Connection.__pools.clear
        end

        # @see lib/rdf/spec/repository.rb in RDF-spec
        it_should_behave_like RDF_Repository
    end
end
