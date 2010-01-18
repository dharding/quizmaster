class GamesQuestion < ActiveRecord::Base
  belongs_to :game
  belongs_to :question
  
  has_many :answers
end