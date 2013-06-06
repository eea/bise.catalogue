require 'spec_helper'

describe Document do

    # ---------- VALIDATIONS ----------
    it { should validate_presence_of(:site) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:english_title) }
    it { should validate_presence_of(:author) }

    it { should validate_presence_of(:file) }

    it { should validate_presence_of(:languages) }


    # it { should have_and_belongs_to_many(:countries) }
    # it { should have_and_belongs_to_many(:concepts) }


    it "is a valid document" do
        FactoryGirl.create(:document).should be_valid
    end

    it "is valid without site" do
        document = FactoryGirl.create(:document)
        # document.site = nl
        document.should be_valid
    end

    # pending "add some examples to (or delete) #{__FILE__}"


end
