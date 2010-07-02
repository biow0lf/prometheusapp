require 'test_helper'

class Test::Unit::TestCase
  def self.should_have_112_groups
    should "have 112 groups in database" do
      Group.delete_all
      Group.update_from_gitalt("test/data/GROUPS_Sisyphus", "ALT Linux", "Sisyphus")
      assert_equal(Group.count(:all), 112)
    end
  end
end

class GroupTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :branch, :vendor
  should_have_112_groups
end

