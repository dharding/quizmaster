require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Game do
  it "should have many teams" do
    should have_many(:teams)
  end
  
  it "should require a number of rounds" do
    should validate_presence_of(:rounds)
  end
  
  it "should require a number of questions per round" do
    should validate_presence_of(:questions_per_round)
  end
  
  it "should have many questions" do
    should have_many(:questions)
  end
end