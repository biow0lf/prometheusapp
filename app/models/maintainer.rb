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
end
