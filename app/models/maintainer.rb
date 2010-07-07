class Maintainer < ActiveRecord::Base
  validates_presence_of :name, :email, :login, :team

  validate :uniqueness_of_email_login_and_team

  def uniqueness_of_email_login_and_team
    errors.add(:uniq, "should be uniq") if Maintainer.count(:all, :conditions => {
                                                                    :email => email,
                                                                    :login => login,
                                                                    :team => team } ) == 1
  end

  def self.top15
    find_by_sql("SELECT COUNT(acls.package) AS counter,
                        maintainers.name AS name,
                        maintainers.login AS login
                 FROM acls, maintainers
                 WHERE acls.branch = 'Sisyphus'
                 AND acls.vendor = 'ALT Linux'
                 AND acls.login = maintainers.login
                 AND maintainers.team = 'no'
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY 1 DESC LIMIT 15")
  end

  # TODO: write test for this
  def self.update_maintainer_list(vendor, branch, path)
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        maintainer = rpm[1015]
        maintainer_name = maintainer.split('<')[0].chomp
        maintainer_name.strip!
        maintainer_email = maintainer.chop.split('<')[1]

        maintainer_email.downcase!

        maintainer_email.gsub!(' at altlinux.ru', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux.org', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot org', '@altlinux.org')
        maintainer_email.gsub!(' at altlinux dot ru', '@altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.org', '@packages.altlinux.org')
        maintainer_email.gsub!(' at packages.altlinux.ru', '@packages.altlinux.org')
        maintainer_email.gsub!('@packages.altlinux.ru', '@packages.altlinux.org')

        maintainer_login = maintainer_email.split('@')[0]
        maintainer_domain = maintainer_email.split('@')[1]

        maintainer2 = Maintainer.new

        if maintainer_domain == 'packages.altlinux.org'
          Maintainer.create(:team => 'yes', :login => '@' + maintainer_login, :name => maintainer_name, :email => maintainer_email)
        else
          Maintainer.create(:team => 'no', :login => maintainer_login, :name => maintainer_name, :email => maintainer_email)
        end
      rescue RuntimeError
        puts "Bad src.rpm -- " + file
      end
    end
  end

end

