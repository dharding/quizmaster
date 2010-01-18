class FixGameTeamsColNames < ActiveRecord::Migration
  def self.up
    remove_column :games_teams, :games_id
    add_column :games_teams, :game_id, :integer, :null => false
    remove_column :games_teams, :teams_id
    add_column :games_teams, :team_id, :integer, :null => false
  end

  def self.down
    remove_column :games_teams, :game_id
    add_column :games_teams, :games_id, :integer, :null => false
    remove_column :games_teams, :team_id
    add_column :games_teams, :teams_id, :integer, :null => false
  end
end
