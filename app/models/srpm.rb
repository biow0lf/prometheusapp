class Srpm < ActiveRecord::Base
  validates_presence_of :branch, :vendor, :filename, :name, :version, :release
  validate :uniqueness_of_srpm
  default_scope order('name')

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

  # TODO: write unit tests for this:
  def self.import_srpms(vendor, branch, path)
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        srpm = Srpm.new
        srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
        srpm.name = rpm.name
        srpm.version = rpm.version.v
        srpm.release = rpm.version.r
        srpm.group = rpm[1016]
        srpm.epoch = rpm[1003]
        srpm.summary = rpm[1004]
        srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        srpm.license = rpm[1014]
        srpm.url = rpm[1020]
        srpm.description = rpm[1005]
        #srpm.vendor = rpm[1011]
        #srpm.distribution = rpm[1010]
        srpm.buildtime = Time.at(rpm[1006])
        srpm.size = File.size(file)
        srpm.branch = branch
        srpm.vendor = vendor
        srpm.save!
      rescue RuntimeError
        puts "Bad src.rpm -- " + file
      end
    end
  end

end

