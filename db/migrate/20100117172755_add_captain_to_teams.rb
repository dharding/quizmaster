class AddCaptainToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :captain_id, :integer
  end

  def self.down
    remove_column :teams, :captain_id
  end
end
