require File.dirname(__FILE__) + '/../spec_helper'

describe Question do
  it "should require question text, an answer, and a difficulty" do
    Question.should validate_presence_of :ask
    Question.should validate_presence_of :answer
    Question.should validate_presence_of :difficulty
    
    q = Factory.build(:question)
    q.ask = nil
    q.answer = nil
    q.difficulty = nil
    q.should_not be_valid
    q.errors.should be_invalid(:ask)
    q.errors.should be_invalid(:answer)
    q.errors.should be_invalid(:difficulty)
  end
end