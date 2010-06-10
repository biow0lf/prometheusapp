class CreateAcls < ActiveRecord::Migration
  def self.up
    create_table :acls do |t|
      t.string :package
      t.string :login
      t.string :branch
      t.string :vendor

      t.timestamps
    end

    add_index "acls", ["package"], :name => "index_acls_on_package"
    add_index "acls", ["login"],   :name => "index_acls_on_login"
    add_index "acls", ["branch"],  :name => "index_acls_on_branch"
    add_index "acls", ["vendor"],  :name => "index_acls_on_vendor"

  end

  def self.down
    drop_table :acls
  end
end
