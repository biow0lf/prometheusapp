require 'test_helper'

class Test::Unit::TestCase
  def self.should_have_15879_acls
    should "have 15879 acls in database" do
      Acl.delete_all
      Acl.update_from_gitalt('ALT Linux', 'Sisyphus', 'test/data/list.packages.sisyphus')
      assert_equal(Acl.count(:all), 15879)
    end
  end

  def self.should_not_update_if_acl_file_empty
    should "not update if ACL file epmty" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt('ALT Linux', 'Sisyphus', 'test/data/list.packages.sisyphus1')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_not_update_if_url_is_empty
    should "not update if url is empty" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt('ALT Linux', 'Sisyphus', '')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_not_update_if_branch_is_empty
    should "not update if branch is empty" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt('ALT Linux', '', 'test/data/list.packages.sisyphus1')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_not_update_if_vendor_is_empty
    should "not update if vendor is empty" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt('', 'Sisyphus', 'test/data/list.packages.sisyphus1')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_not_update_if_url_branch_vendor_is_empty
    should "not update if url and/or branch and/or vendor is empty" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt('', '', '')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_not_add_twice
    should "not add twice data to database" do
      Acl.delete_all
      Acl.update_from_gitalt('ALT Linux', 'Sisyphus', 'test/data/list.packages.sisyphus')
      Acl.update_from_gitalt('ALT Linux', 'Sisyphus', 'test/data/list.packages.sisyphus')
      assert_equal(Acl.count(:all), 15879)
    end
  end

  def self.should_fail_on_int
    should "fail on int" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'kas', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.update_from_gitalt(5, 5, 'test/data/list.packages.sisyphus')
      assert_equal(Acl.count(:all), 2)
    end
  end

  def self.should_check_acl_for_exists_and_not_add_twice
    should "check acl for exists and not add twice" do
      Acl.delete_all
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      Acl.create(:package => 'glibc', :login => 'ldv', :vendor => 'ALT Linux', :branch => 'Sisyphus')
      assert_equal(Acl.count(:all), 1)
    end
  end

end

class AclTest < ActiveSupport::TestCase
  should_validate_presence_of :package, :login, :branch, :vendor
  should_have_15879_acls
  should_not_update_if_acl_file_empty
  should_not_update_if_url_is_empty
  should_not_update_if_branch_is_empty
  should_not_update_if_vendor_is_empty
  should_not_update_if_url_branch_vendor_is_empty
  should_not_add_twice
  should_fail_on_int
  should_check_acl_for_exists_and_not_add_twice
end
