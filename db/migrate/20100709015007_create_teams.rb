class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.string :login
      t.string :branch
      t.string :vendor
      t.string :leader

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end