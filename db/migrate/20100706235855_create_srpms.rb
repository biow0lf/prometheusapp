class CreateSrpms < ActiveRecord::Migration
  def self.up
    create_table :srpms do |t|
      t.string :branch
      t.string :vendor
      t.string :filename
      t.string :name
      t.string :version
      t.string :release
      t.string :epoch
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.datetime :buildtime
      t.string :size
      t.string :group
      t.string :repocop, :default => "skip"

      t.timestamps
    end

    add_index "srpms", ["branch"], :name => "index_srpms_on_branch"
    add_index "srpms", ["name"], :name => "index_srpms_on_name"
    add_index "srpms", ["vendor"], :name => "index_srpms_on_vendor"

  end

  def self.down
    drop_table :srpms
  end
end
