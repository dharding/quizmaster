require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Team do
  it "should require a unique name" do
    Team.should require_a_unique(:name)
    t = Team.new
    t.should_not be_valid
    t.errors.should be_invalid(:name)
  end
  
  it "should have many members" do
    should have_many(:members)
  end
  
  it "should belong to captain" do
    should belong_to(:captain)
  end
  
  it "should have many answers" do
    should have_many(:answers)
  end
end