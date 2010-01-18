class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers, :force => true do |t|
      t.integer :games_question_id, :null => false
      t.integer :team_id, :null => false
      t.text :content
      t.boolean :correct, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
