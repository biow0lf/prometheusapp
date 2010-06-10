require 'test_helper'

class Test::Unit::TestCase
  def self.should_not_add_bug_if_bug_id_is_already_used
    should "not add bug if bug_id is already used" do
      Bug.delete_all
      Bug.create(:bug_id => 1)
      Bug.create(:bug_id => 1)
      assert_equal(Bug.count(:all), 1)
    end
  end
  
  def self.should_have_23224_bugs
    should "have 23224 bugs in database" do
      Bug.delete_all
      Bug.update_bugs_from_bugzilla_alt("test/data/bugzilla.altlinux.org")
      assert_equal(Bug.count(:all), 23224)
    end
  end
end

class BugTest < ActiveSupport::TestCase
  should_validate_presence_of :bug_id
  should_not_add_bug_if_bug_id_is_already_used
  should_have_23224_bugs
end
