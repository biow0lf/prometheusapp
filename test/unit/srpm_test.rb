require 'test_helper'

class Test::Unit::TestCase
  def self.should_check_srpm_for_exists_and_not_add_twice
    should "check srpm for exists and not add twice" do
      Srpm.delete_all
      Srpm.create(:branch => 'Sisyphus', :vendor => 'ALT Linux', :filename => 'glibc-2.11.2-alt2.src.rpm', :name => 'glibc', :version => '2.11.2', :release => 'alt2')
      Srpm.create(:branch => 'Sisyphus', :vendor => 'ALT Linux', :filename => 'glibc-2.11.2-alt2.src.rpm', :name => 'glibc', :version => '2.11.2', :release => 'alt2')
      assert_equal(Srpm.count(:all), 1)
    end
  end

  def self.should_count_packages_in_sisyphus
    should "count packages in sisyphus" do
      Srpm.delete_all
      Srpm.create(:branch => 'Sisyphus', :vendor => 'ALT Linux', :filename => 'glibc-2.11.2-alt2.src.rpm', :name => 'glibc', :version => '2.11.2', :release => 'alt2')
      Srpm.create(:branch => 'Sisyphus', :vendor => 'ALT Linux', :filename => 'openbox-3.4.11.1-alt1.src.rpm', :name => 'openbox', :version => '3.4.11.1', :release => 'alt1')
      assert_equal(Srpm.count_srpms_in_sisyphus, 2)
    end
  end

end

class SrpmTest < ActiveSupport::TestCase
  should_validate_presence_of :branch, :vendor, :filename, :name, :version, :release
  should_have_db_index :branch, :vendor, :name
  should_check_srpm_for_exists_and_not_add_twice
  should_count_packages_in_sisyphus
end
