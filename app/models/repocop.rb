class Repocop < ActiveRecord::Base
  validates_presence_of :name, :version, :release, :arch, :srcname, :srcversion, :srcrel, :testname, :status

  # TODO: write tests for this
  def self.update_repocop
    ActiveRecord::Base.transaction do
      Repocop.delete_all

      url = "http://repocop.altlinux.org/pub/repocop/prometeus2/prometeus2.txt"
      file = open(URI.escape(url)).read

      file.each_line do |line|
        ActiveRecord::Base.connection.execute(line)
      end
    end
  end

  # TODO: write tests for this
  def self.update_repocop_cache
    srpms = Srpm.all :conditions => { :vendor => 'ALT Linux', :branch => 'Sisyphus' }
    srpms.each do |srpm|
      repocops = Repocop.all :conditions => {
                               :srcname => srpm.name,
                               :srcversion => srpm.version,
                               :srcrel => srpm.release }

      repocop_status = 'skip'
      repocops.each do |repocop|
        repocop_status = 'ok' if repocop.status == 'ok' and repocop_status != 'info' and repocop_status != 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'info' if repocop.status == 'info' and repocop_status != 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'experimental' if repocop.status == 'experimental' and repocop_status != 'warn' and repocop_status != 'fail'
        repocop_status = 'warn' if repocop.status == 'warn' and repocop_status != 'fail'
        repocop_status = 'fail' if repocop.status == 'fail'
      end
      srpm.repocop = repocop_status
      srpm.save(:validate => false)
    end
  end

end
