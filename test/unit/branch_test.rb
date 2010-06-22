require 'test_helper'

class Test::Unit::TestCase
  def self.should_check_branch_for_exists_and_not_add_twice
    should "check branch for exists and not add twice" do
      Branch.delete_all
      Branch.create(:distribution => 'Sisyphus', :vendor => 'ALT Linux', :order_id => 1)
      Branch.create(:distribution => 'Sisyphus', :vendor => 'ALT Linux', :order_id => 1)
      assert_equal(1, Branch.count(:all))
    end
  end
end

class BranchTest < ActiveSupport::TestCase
  should_validate_presence_of :distribution, :vendor, :order_id
  should_check_branch_for_exists_and_not_add_twice
end
