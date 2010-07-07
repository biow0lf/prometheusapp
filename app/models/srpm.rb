class Srpm < ActiveRecord::Base
  validates_presence_of :branch, :vendor, :filename, :name, :version, :release
  validate :uniqueness_of_srpm

  def uniqueness_of_srpm
    errors.add(:uniq, "should be uniq") if Srpm.count(:all, :conditions => {
                                                              :branch => branch,
                                                              :vendor => vendor,
                                                              :filename => filename,
                                                              :name => name,
                                                              :version => version,
                                                              :release => release } ) == 1
  end


  def self.count_srpms_in_sisyphus
    count :conditions => { :branch => 'Sisyphus', :vendor => 'ALT Linux' }
  end

end

