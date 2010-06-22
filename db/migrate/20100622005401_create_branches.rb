class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :distribution
      t.string :vendor
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
