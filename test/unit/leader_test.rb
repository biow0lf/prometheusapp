require 'test_helper'

class Test::Unit::TestCase
  def self.should_check_leader_for_exists_and_not_add_twice
    should "check acl for exists and not add twice" do
      Leader.delete_all
      Leader.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Leader.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      assert_equal(Leader.count(:all), 1)
    end
  end

  def self.should_have_9882_leaders
    should "have 9882 leaders in database" do
      Leader.delete_all
      Leader.update_from_gitalt('ALT Linux', 'Sisyphus', 'test/data/list.packages.sisyphus')
      assert_equal(Leader.count(:all), 9882)
    end
  end

end

class LeaderTest < ActiveSupport::TestCase
  should_validate_presence_of :package, :login, :branch, :vendor
  should_check_leader_for_exists_and_not_add_twice
  should_have_9882_leaders
end
