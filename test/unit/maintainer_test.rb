require 'test_helper'

class Test::Unit::TestCase
  def self.should_check_maintainer_for_exists_and_not_add_twice
    should "check maintainer for exists and not add twice" do
      Maintainer.delete_all
      Maintainer.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => 'no')
      Maintainer.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => 'no')
      assert_equal(Maintainer.count(:all), 1)
    end
  end
end

class MaintainerTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :email, :login, :team
  should_check_maintainer_for_exists_and_not_add_twice
end
