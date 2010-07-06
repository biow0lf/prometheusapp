class Leader < ActiveRecord::Base
  validates_presence_of :package, :login, :branch, :vendor
  validate :uniqueness_of_package_login_branch_vendor

  def uniqueness_of_package_login_branch_vendor
    errors.add(:uniq, "should be uniq") if Leader.count(:all, :conditions => {
                                                                :package => package,
                                                                :login => login,
                                                                :branch => branch,
                                                                :vendor => vendor } ) == 1
  end

end
