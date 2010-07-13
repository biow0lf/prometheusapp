class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :filename
      t.string :sourcepackage
      t.string :name
      t.string :version
      t.string :release
      t.string :epoch
      t.string :group
      t.string :arch
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.datetime :buildtime
      t.string :size
      t.string :branch
      t.string :vendor

      t.timestamps
    end

    add_index "packages", ["arch"], :name => "index_packages_on_arch"
    add_index "packages", ["branch"], :name => "index_packages_on_branch"
    add_index "packages", ["sourcepackage"], :name => "index_packages_on_sourcepackage"
    add_index "packages", ["vendor"], :name => "index_packages_on_vendor"

  end

  def self.down
    drop_table :packages
  end
end
