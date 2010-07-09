class Acl < ActiveRecord::Base
  validates_presence_of :package, :login, :branch, :vendor
  validate :uniqueness_of_package_login_branch_vendor

  has_one :srpm, :foreign_key => 'name', :primary_key => 'package', :conditions => { :branch => '#{self.branch}', :vendor => '#{self.vendor}' }


  def uniqueness_of_package_login_branch_vendor
    errors.add(:uniq, "should be uniq") if Acl.count(:all, :conditions => {
                                                             :package => package,
                                                             :login => login,
                                                             :branch => branch,
                                                             :vendor => vendor } ) == 1
  end

  def self.update_from_gitalt(vendor, branch, url)
    if url.class.to_s == 'String' and !url.empty? and
       vendor.class.to_s == 'String' and !vendor.empty? and
       branch.class.to_s == 'String' and !branch.empty?

      file = open(URI.escape(url)).read
      if file.bytesize != 0

        ActiveRecord::Base.transaction do
          ActiveRecord::Base.connection.execute("DELETE FROM acls WHERE branch = '" + branch + "' AND vendor = '" + vendor + "'")
          file.each_line do |line|
            package = line.split[0]
            for i in 1..line.split.count-1
              login = line.split[i]
              login = 'php-coder' if login == 'php_coder'
              login = '@vim-plugins' if login == '@vim_plugins'
              login = 'p_solntsev' if login == 'psolntsev'

              counter = Acl.count :all, :conditions => { :package => package,
                                                         :login => login,
                                                         :branch => branch,
                                                         :vendor => vendor }

              if counter == 0
                Acl.create :package => package, :login => login, :branch => branch, :vendor => vendor
              else
                puts Time.now.to_s + "broken Acl list"
              end # if counter == 0
            end # for i in 1..line.split.count-1
          end # file.each_line for |line|
        end # ActiveRecord::Base.transaction do
      end # if file.bytesize != 0
    end # if url.class...
  end

end
