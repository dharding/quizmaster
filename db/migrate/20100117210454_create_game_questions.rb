class CreateGameQuestions < ActiveRecord::Migration
  def self.up
    create_table :games_questions, :force => true do |t|
      t.integer :game_id, :null => false
      t.integer :question_id, :null => false
    end
  end

  def self.down
    drop_table :games_questions
  end
end
