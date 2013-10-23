require 'spec_helper'

describe Link do

  before do
    @link = FactoryGirl.create(:link)
  end

  it { @link.should be_valid }

end
