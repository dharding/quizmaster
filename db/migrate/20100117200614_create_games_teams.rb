class CreateGamesTeams < ActiveRecord::Migration
  def self.up
    create_table :games_teams, :force => true do |t|
      t.references :games
      t.references :teams
    end
  end

  def self.down
    drop_table :games_teams
  end
end
