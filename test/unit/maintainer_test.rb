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
  
  def self.should_return_15_records
    should "return 15 records" do
      Maintainer.delete_all
      Maintainer.create(:name => 'q', :email => 'q@altlinux.org', :login => 'q', :team => 'no')
      Maintainer.create(:name => 'w', :email => 'w@altlinux.org', :login => 'w', :team => 'no')
      Maintainer.create(:name => 'e', :email => 'e@altlinux.org', :login => 'e', :team => 'no')
      Maintainer.create(:name => 'r', :email => 'r@altlinux.org', :login => 'r', :team => 'no')
      Maintainer.create(:name => 't', :email => 't@altlinux.org', :login => 't', :team => 'no')
      Maintainer.create(:name => 'y', :email => 'y@altlinux.org', :login => 'y', :team => 'no')
      Maintainer.create(:name => 'u', :email => 'u@altlinux.org', :login => 'u', :team => 'no')
      Maintainer.create(:name => 'i', :email => 'i@altlinux.org', :login => 'i', :team => 'no')
      Maintainer.create(:name => 'o', :email => 'o@altlinux.org', :login => 'o', :team => 'no')
      Maintainer.create(:name => 'p', :email => 'p@altlinux.org', :login => 'p', :team => 'no')
      Maintainer.create(:name => 'q1', :email => 'q1@altlinux.org', :login => 'q1', :team => 'no')
      Maintainer.create(:name => 'w1', :email => 'w1@altlinux.org', :login => 'w1', :team => 'no')
      Maintainer.create(:name => 'e1', :email => 'e1@altlinux.org', :login => 'e1', :team => 'no')
      Maintainer.create(:name => 'r1', :email => 'r1@altlinux.org', :login => 'r1', :team => 'no')
      Maintainer.create(:name => 't1', :email => 't1@altlinux.org', :login => 't1', :team => 'no')
      Maintainer.create(:name => 'y1', :email => 'y1@altlinux.org', :login => 'y1', :team => 'no')
      Maintainer.create(:name => 'u1', :email => 'u1@altlinux.org', :login => 'u1', :team => 'no')
      Maintainer.create(:name => 'i1', :email => 'i1@altlinux.org', :login => 'i1', :team => 'no')
      Maintainer.create(:name => 'o1', :email => 'o1@altlinux.org', :login => 'o1', :team => 'no')
      Maintainer.create(:name => 'p1', :email => 'p1@altlinux.org', :login => 'p1', :team => 'no')
      assert_equal(count(Maintainer.top15), 15)
    end
  end
end

class MaintainerTest < ActiveSupport::TestCase
  should_validate_presence_of :name, :email, :login, :team
  should_check_maintainer_for_exists_and_not_add_twice
end
