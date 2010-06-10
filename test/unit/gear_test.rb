require 'test_helper'

class Test::Unit::TestCase
  def self.should_have_9953_gitrepos
    should "have 9953 gitrepos in database" do
      Gear.delete_all
      Gear.update_from_gitalt("test/data/people-packages-list")
      assert_equal(Gear.count(:all), 9953)
    end
  end

  def self.should_have_440_gitrepos_for_builder
    should "have 440 gitrepos in database for ldv@" do
      Gear.delete_all
      Gear.update_from_gitalt("test/data/people-packages-list")
      assert_equal(Gear.count(:all, :conditions => { :login => 'ldv' }), 440)
    end
  end

  def self.should_have_0_gitrepos_for_builder
    should "have 0 gitrepos in database for aaaaa@" do
      Gear.delete_all
      Gear.update_from_gitalt("test/data/people-packages-list")
      assert_equal(Gear.count(:all, :conditions => { :login => 'aaaaa' }), 0)
    end
  end

  def self.should_have_5_gitrepos_for_package
    should "have 5 gitrepos in database for package 'glibc'" do
      Gear.delete_all
      Gear.update_from_gitalt("test/data/people-packages-list")
      assert_equal(Gear.count(:all, :conditions => { :package => 'glibc' }), 5)
    end
  end

  def self.should_not_update_if_url_to_gitrepos_is_empty
    should "not update if url to gitrepos is empty" do
      Gear.delete_all
      Gear.create(:package => 'glibc', :login => 'ldv', :lastchange => Time.now())
      Gear.update_from_gitalt("")
      assert_equal(Gear.count(:all), 1)
    end
  end

  def self.should_not_update_if_gitrepos_file_size_is_zero
    should "not update if gitrepos file size is zero" do
      Gear.delete_all
      Gear.create(:package => 'glibc', :login => 'ldv', :lastchange => Time.now())
      Gear.update_from_gitalt("test/data/people-packages-list1")
      assert_equal(Gear.count(:all), 1)
    end
  end

  def self.should_not_add_twice
    should "not add twice data to database" do
      Gear.delete_all
      Gear.update_from_gitalt("test/data/people-packages-list")
      Gear.update_from_gitalt("test/data/people-packages-list")
      assert_equal(Gear.count(:all), 9953)
    end
  end

  def self.should_fail_on_int
    should "fail on int" do
      Gear.delete_all
      Gear.create(:package => 'glibc', :login => 'ldv', :lastchange => Time.now())
      Gear.update_from_gitalt(1)
      assert_equal(Gear.count(:all), 1)
    end
  end

  def self.should_check_gear_for_exists_and_not_add_twice
    should "check gear for exists and not add twice" do
      Gear.delete_all
      Gear.create(:package => 'glibc', :login => 'ldv', :lastchange => Time.now())
      Gear.create(:package => 'glibc', :login => 'ldv', :lastchange => Time.now())
      assert_equal(Gear.count(:all), 1)      
    end
  end
end

class GearTest < ActiveSupport::TestCase
  should_validate_presence_of :package, :login, :lastchange
  should_have_9953_gitrepos
  should_have_440_gitrepos_for_builder
  should_have_0_gitrepos_for_builder
  should_have_5_gitrepos_for_package
  should_not_update_if_url_to_gitrepos_is_empty
  should_not_update_if_gitrepos_file_size_is_zero
  should_not_add_twice
  should_fail_on_int
  should_check_gear_for_exists_and_not_add_twice
end
