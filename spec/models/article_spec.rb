require 'spec_helper'


describe Article do

    it "is invalid without site" do
        should validate_presence_of(:site)
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

    it "is invalid without assigned language" do
        should validate_presence_of(:language_ids)
    end

    it "is a valid article" do
        FactoryGirl.create(:article).should be_valid
    end

    it "is valid without site" do
        article = FactoryGirl.create(:article)
        article.site = nil
        article.should be_valid
    end

end
