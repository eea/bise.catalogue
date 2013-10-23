require 'spec_helper'

describe Site do

  before do
    @site = FactoryGirl.create :site
  end

  it { @site.should be_valid}

end
