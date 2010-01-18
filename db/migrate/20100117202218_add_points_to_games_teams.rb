class AddPointsToGamesTeams < ActiveRecord::Migration
  def self.up
    add_column :games_teams, :points, :integer, :default => 0
    add_column :games_teams, :winner, :boolean, :default => false
  end

  def self.down
    remove_column :games_teams, :winner
    remove_column :games_teams, :points
  end
end
