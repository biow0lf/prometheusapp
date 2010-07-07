require 'test_helper'

class SrpmTest < ActiveSupport::TestCase
  should_validate_presence_of :branch, :vendor, :filename, :name, :version, :release
  should_have_db_index :branch, :vendor, :name
end
