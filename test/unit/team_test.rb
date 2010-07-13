require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :login, :branch, :vendor, :leader
end
