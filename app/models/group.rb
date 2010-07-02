class Group < ActiveRecord::Base
  validates_presence_of :name, :vendor, :branch
  default_scope order('name')

  def self.update_from_gitalt(url, vendor, branch)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = '" + branch.to_s + "' AND vendor = '" + vendor.to_s + "'")
      file = open(URI.escape(url.to_s)).read
      file.each_line do |line|
        Group.create :name => line.gsub(/\n/,''), :branch => branch, :vendor => vendor
      end
    end
  end

end

