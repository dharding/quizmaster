class Team < ActiveRecord::Migration
  def self.up
    create_table "teams", :force => true do |t|
      t.string "name", :limit => 50, :null => false
    end
  end

  def self.down
    drop_table "teams"
  end
end
