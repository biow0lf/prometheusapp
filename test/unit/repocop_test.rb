require 'test_helper'

class RepocopTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :version, :release, :arch, :srcname, :srcversion, :srcrel, :testname, :status
  should_have_db_index :srcname, :srcversion, :srcrel
end
