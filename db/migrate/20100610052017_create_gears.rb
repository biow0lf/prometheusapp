class CreateGears < ActiveRecord::Migration
  def self.up
    create_table :gears do |t|
      t.string :package
      t.string :login
      t.datetime :lastchange

      t.timestamps
    end

    add_index "gears", ["package"],    :name => "index_gears_on_package"
    add_index "gears", ["login"],      :name => "index_gears_on_login"
    add_index "gears", ["lastchange"], :name => "index_gears_on_lastchange"

  end

  def self.down
    drop_table :gears
  end
end
