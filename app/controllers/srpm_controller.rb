class SrpmController < ApplicationController

  def main
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => params[:branch],
                         :vendor => 'ALT Linux' }
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
        @leader = Leader.first :conditions => {
                                 :branch => params[:branch],
                                 :vendor => 'ALT Linux',
                                 :package => params[:name] }
        @maintainer = Maintainer.first :conditions => { :login => @leader.login }
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

end
