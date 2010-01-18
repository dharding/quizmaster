class AddLockedToGamesQuestions < ActiveRecord::Migration
  def self.up
    add_column :games_questions, :locked, :boolean, :default => false
  end

  def self.down
    remove_column :games_questions, :locked
  end
end
