require 'test_helper'

class LeaderTest < ActiveSupport::TestCase
  should_validate_presence_of :package, :login, :branch, :vendor
end
