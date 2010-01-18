class AddActiveAndAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean, :default => false
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin
    remove_column :users, :active
  end
end
