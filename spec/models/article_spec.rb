require 'spec_helper'


describe Article do

    it "is a valid article" do
        FactoryGirl.create(:article).should be_valid
    end

    it "is valid without site" do
        article = FactoryGirl.create(:article)
        article.site = nil
        article.should be_valid
    end

end
