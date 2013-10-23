require 'spec_helper'

describe Taxonomy do

  before do
    @taxonomy = FactoryGirl.create :taxonomy
  end

  it { @taxonomy.should be_valid }

end
