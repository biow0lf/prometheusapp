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

  def self.update_from_gitalt(vendor, branch, url)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM leaders WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")

      file = open(URI.escape(url)).read

      file.each_line do |line|
        package = line.split[0]
        login = line.split[1]
        Leader.create :package => package, :login => login, :branch => branch, :vendor => vendor
      end
    end
  end

end
