class AddCurrentStateToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :current_round, :integer
    add_column :games, :current_question, :integer
    add_column :games, :complete, :boolean, :default => false
    add_column :games, :started, :boolean, :default => false
    add_column :games, :rounds, :integer, :default => 3
    add_column :games, :questions_per_round, :integer, :default => 5
  end

  def self.down
    remove_column :games, :complete
    remove_column :games, :current_question
    remove_column :games, :current_round
    remove_column :games, :started
    remove_column :games, :rounds
    remove_column :games, :questions_per_round
  end
end
