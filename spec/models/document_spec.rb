require 'spec_helper'

describe Document do

    include CarrierWave::Test::Matchers

    before do
        @document = FactoryGirl.create(:document)
    end

    after do
        @document.destroy
    end

    # ---------- VALIDATIONS ----------

    it "is invalid without site" do
        should validate_presence_of(:site)
        @document.site_id = nil
        @document.should_not be_valid
    end

    it "is invalid without title" do
        should validate_presence_of(:title)
    end

    it "is invalid without english title" do
        should validate_presence_of(:english_title)
    end

    it "is invalid without author" do
        should validate_presence_of(:author)
    end


    it "is invalid without file" do
        should validate_presence_of(:file)
    end

    it "is invalid without assigned language" do
        should validate_presence_of(:language_ids)
    end


    #### # it { should have_and_belongs_to_many(:countries) }
    #### # it { should have_and_belongs_to_many(:concepts) }


    it "is a valid document" do
        @document.should be_valid
    end

    it "is invalid if file exists" do
        tmp_doc = @document.dup
        tmp_doc.should have(1).error_on(:file)
    end

end
