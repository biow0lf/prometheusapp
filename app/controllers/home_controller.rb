class HomeController < ApplicationController
  def index
  end

  def groups_list
    @groups = Group.find_groups_in_sisyphus
  end

  def bygroup
    @group = params[:group]
    @group = @group + '/' + params[:group2] if !params[:group2].nil?
    @group = @group + '/' + params[:group3] if !params[:group3].nil?

    @srpms = Srpm.all :conditions => {
                        :group => @group,
                        :branch => 'Sisyphus',
                        :vendor => 'ALT Linux' }
  end

end
