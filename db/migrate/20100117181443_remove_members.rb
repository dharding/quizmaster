class RemoveMembers < ActiveRecord::Migration
  def self.up
    drop_table :members
  end

  def self.down
    create_table :members, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.references :team
      t.timestamps
    end
  end
end
