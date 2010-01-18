class Question < ActiveRecord::Migration
  def self.up
    create_table "questions", :force => true do |t|
      t.string "ask", :null => false
      t.string "answer", :null => false
      t.integer "difficulty", :null => false
    end
  end

  def self.down
    drop_table "questions"
  end
end
