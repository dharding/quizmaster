class AddDefaultsToGameState < ActiveRecord::Migration
  def self.up
    change_column_default :games, :current_question, 0
    change_column_default :games, :current_round, 0
  end

  def self.down
  end
end
