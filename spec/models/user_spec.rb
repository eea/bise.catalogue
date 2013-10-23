require 'spec_helper'

describe User do

  before :each do
    @user = FactoryGirl.create :user
  end

  it { @user.should be_valid }

end
