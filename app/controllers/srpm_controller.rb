class SrpmController < ApplicationController

  def main
    @srpm = Srpm.where(:name => params[:name], :branch => params[:branch], :vendor => 'ALT Linux').first

    if @srpm != nil
      @allsrpms = Srpm.find_by_sql ["SELECT srpms.name, srpms.version,
                                            srpms.release, srpms.branch,
                                            order_id
                                     FROM srpms, branches
                                     WHERE srpms.branch = branches.distribution
                                     AND srpms.vendor = branches.vendor
                                     AND srpms.name = ?
                                     ORDER BY branches.order_id ASC", params[:name]]

      if params[:branch] == 'Sisyphus' or
         params[:branch] == '5.1' or
         params[:branch] == '5.0' or
         params[:branch] == '4.1' or
         params[:branch] == '4.0'
        @packages = Package.all :conditions => {
                                  :branch => 'Sisyphus',
                                  :vendor => 'ALT Linux',
                                  :sourcepackage => @srpm.filename,
                                  :arch => ["noarch", "i586"] },
                                :order => 'name ASC'
        @leader = Leader.where(:branch => params[:branch], :vendor => 'ALT Linux', :package => params[:name]).first
        @maintainer = Maintainer.where(:login => @leader.login).first
      elsif params[:branch] == 'Platform5'
        @packages = Package.all :conditions => {
                                  :branch => 'Sisyphus',
                                  :vendor => 'ALT Linux',
                                  :sourcepackage => @srpm.filename,
                                  :arch => ["noarch", "i586"] },
                                :order => 'name ASC'
      end
    else
      render :action => "nosuchpackage"
    end
  end

  def changelog
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def rawspec
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def download
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
    if @srpm != nil
      @allsrpms = Srpm.find_by_sql ["SELECT srpms.name, srpms.version,
                                            srpms.release, srpms.branch,
                                            order_id
                                     FROM srpms, branches
                                     WHERE srpms.branch = branches.name
                                     AND srpms.name = ?
                                     ORDER BY branches.order_id ASC", params[:name]]
      @i586 = Package.all :conditions => {
                            :branch => params[:branch],
                            :vendor => 'ALT Linux',
                            :sourcepackage => @srpm.filename,
                            :arch => 'i586' },
                          :order => 'name ASC'
      @noarch = Package.all :conditions => {
                              :branch => params[:branch],
                              :vendor => 'ALT Linux',
                              :sourcepackage => @srpm.filename,
                              :arch => 'noarch' },
                            :order => 'name ASC'
      @x86_64 = Package.all :conditions => {
                              :branch => params[:branch],
                              :vendor => 'ALT Linux',
                              :sourcepackage => @srpm.filename,
                              :arch => 'x86_64' },
                            :order => 'name ASC'
    else
      render :action => "nosuchpackage"
    end
  end

  def gear
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
    if @srpm != nil
      @gears = Gear.all :conditions => { :package => @srpm.name },
                          :order => 'lastchange DESC'
    else
      render :action => "nosuchpackage"
    end
  end

  def bugs
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                      :order => "bug_id DESC"
  end

  def allbugs
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                       :order => "bug_id DESC"
  end

  def repocop
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
    if @srpm != nil
      @repocops = Repocop.all :conditions => {
                                :srcname => @srpm.name,
                                :srcversion => @srpm.version,
                                :srcrel => @srpm.release }
    else
      render :action => "nosuchpackage"
    end
  end

end
