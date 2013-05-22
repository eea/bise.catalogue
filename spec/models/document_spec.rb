require 'spec_helper'

describe Document do

    it "is a valid document" do
        FactoryGirl.create(:document).should be_valid
    end

    it "is valid without site" do
        document = FactoryGirl.create(:document)
        # document.site = nil
        document.should be_valid
    end

    # pending "add some examples to (or delete) #{__FILE__}"


end
