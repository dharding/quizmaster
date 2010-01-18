class Answer < ActiveRecord::Base
  belongs_to :asked_question, :class_name => "GamesQuestion", :foreign_key => "games_question_id"
  belongs_to :team
  
  attr_protected :correct
end