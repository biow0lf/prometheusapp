class Gear < ActiveRecord::Base
  validates_presence_of :package, :login, :lastchange
  validate :uniqueness_of_package_and_login

  default_scope order('LOWER(package)')

  def uniqueness_of_package_and_login
    errors.add(:uniq, "should be uniq") if Gear.count(:all, :conditions => {
                                                              :package => package,
                                                              :login => login } ) == 1
  end

  def self.update_from_gitalt(url)
    if url.class.to_s == 'String' and !url.empty?
      file = open(URI.escape(url)).read
      if file.bytesize != 0
        ActiveRecord::Base.transaction do
          Gear.delete_all
          file.each_line do |line|
            gear = line.split[0]
            login = gear.split('/')[2]
            login = 'php-coder' if login == 'php_coder'
            package = gear.split('/')[4]
            time = Time.at(line.split[1].to_i)

            counter = Gear.count :all, :conditions => {
                                         :package => package.gsub(/\.git/,''),
                                         :login => login,
                                         :lastchange => time }

            if counter == 0
              Gear.create(:package => package.gsub(/\.git/,''), :login => login, :lastchange => time)
            else
              puts Time.now.to_s + "broken Gear list"
            end # if counter == 0
          end # file.each_line
        end
      end
    end
  end

end
