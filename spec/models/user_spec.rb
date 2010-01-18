require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should belong to a team" do
    should belong_to(:team)
  end
  
  it "should have one captained team" do
    should have_one(:captained_team)
  end
end