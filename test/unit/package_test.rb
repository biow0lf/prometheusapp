require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  should_validate_presence_of :branch, :vendor, :filename, :sourcepackage, :name, :version, :release, :size
  should_have_db_index :branch, :vendor, :arch, :sourcepackage
end
