class PackagerController < ApplicationController

  def info
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
    @acls = Acl.all :select => 'package',
                    :conditions => {
                      :login => params[:login].downcase,
                      :branch => 'Sisyphus',
                      :vendor => 'ALT Linux' }
#                    :include => [:srpm]
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

  def srpms
    #@branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' },
                               :include => [:sisyphus]
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

  def acls
  end

  def gear
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
    @gears = Gear.all :conditions => { :login => params[:login].downcase },
                      :order => 'package ASC'
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

  def bugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :assigned_to => params[:login].downcase + '@altlinux.org',
                         :product => 'Sisyphus' },
                       :order => "bug_id DESC"
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

  def allbugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
     @allbugs = Bug.all :conditions => {
                          :assigned_to => params[:login].downcase + '@altlinux.org',
                          :product => 'Sisyphus' },
                        :order => "bug_id DESC"
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

  def repocop
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => 'no' }
    if @maintainer == nil
      render :action => "nosuchpackager"
    end
  end

end
