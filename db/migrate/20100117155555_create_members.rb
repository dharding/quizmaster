class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.references :team
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
