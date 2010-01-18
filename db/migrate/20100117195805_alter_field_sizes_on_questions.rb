class AlterFieldSizesOnQuestions < ActiveRecord::Migration
  def self.up
    change_column :questions, :ask, :text, :null => false
    change_column :questions, :answer, :text, :null => false
  end

  def self.down
    change_column :questions, :ask, :string, :null => false
    change_column :questions, :answer, :string, :null => false
  end
end
