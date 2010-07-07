class Maintainer < ActiveRecord::Base
  validates_presence_of :name, :email, :login, :team

  validate :uniqueness_of_name_email_login_and_team

  def uniqueness_of_name_email_login_and_team
    errors.add(:uniq, "should be uniq") if Maintainer.count(:all, :conditions => {
                                                                    :name => name,
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
                 AND maintainers.team = false
                 GROUP BY maintainers.name, maintainers.login
                 ORDER BY 1 DESC LIMIT 15")
  end
  
end

