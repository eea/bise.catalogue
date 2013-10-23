require 'spec_helper'


describe Article do

  before do
    @article = FactoryGirl.create(:article)
  end

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
    @article.should be_valid
  end

end
