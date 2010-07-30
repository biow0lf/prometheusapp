class ApiController < ApplicationController
#  respond_to :html, :xml, :json
#  respond_to :html
  layout nil

  def count
    @counter = Srpm.where(:branch => params[:branch], :vendor => params[:vendor]).count
  end

  def maintainers
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus_without_counter
  end

  def maintainer_name
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
  end

  def maintainer_acl
    @acls = Acl.all :select => 'package',
                      :conditions => {
                      :login => params[:login].downcase,
                      :branch => 'Sisyphus',
                      :vendor => 'ALT Linux' }
  end

  def maintainer_gear
    @gears = Gear.all :conditions => { :login => params[:login].downcase }
  end

  def maintainer_bugs
    @bugs = Bug.all :select => 'bug_id',
                    :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                      :order => "bug_id DESC"
  end

  def maintainer_allbugs
    @bugs = Bug.all :select => 'bug_id',
                    :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus' },
                    :order => "bug_id DESC"
  end

  def maintainer_repocop
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
  end

  def srpm_get
    @srpm = Srpm.where(:name => params[:name], :branch => params[:branch], :vendor => 'ALT Linux').first
    if @srpm != nil
    end
  end

end
