class Group < ActiveRecord::Base
  validates_presence_of :name, :vendor, :branch
  default_scope order('name')

  def self.update_from_gitalt(vendor, branch, url)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM groups WHERE branch = '" + branch.to_s + "' AND vendor = '" + vendor.to_s + "'")
      file = open(URI.escape(url.to_s)).read
      file.each_line do |line|
        Group.create :name => line.gsub(/\n/,''), :branch => branch, :vendor => vendor
      end
    end
  end

  # TODO: write this for this
  def self.find_groups_in_sisyphus
    find_by_sql("SELECT COUNT(srpms.name) AS counter, groups.name
                 FROM srpms, groups
                 WHERE srpms.branch = 'Sisyphus'
                 AND srpms.vendor = 'ALT Linux'
                 AND groups.branch = srpms.branch
                 AND groups.vendor = srpms.vendor
                 AND srpms.`group` = groups.name
                 GROUP BY groups.id
                 ORDER BY groups.name ASC")
  end

end

