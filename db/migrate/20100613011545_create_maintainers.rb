class CreateMaintainers < ActiveRecord::Migration
  def self.up
    create_table :maintainers do |t|
      t.string :name
      t.string :email
      t.string :login
      t.string :team, :default => 'no', :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :maintainers
  end
end
