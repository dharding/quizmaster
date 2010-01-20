class AddPointsToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :points, :integer, :default => 0
  end

  def self.down
    remove_column :answers, :points
  end
end
