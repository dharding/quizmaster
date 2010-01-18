class Question < ActiveRecord::Base
  validates_presence_of :ask
  validates_presence_of :answer
  validates_presence_of :difficulty
  validates_numericality_of :difficulty
  
  acts_as_taggable_on :tags
  
  DIFFICULTIES = [["Easy", 1], ["Normal", 2], ["Hard", 3]]
  
  has_many :games_questions
  has_many :games, :through => :games_questions
end