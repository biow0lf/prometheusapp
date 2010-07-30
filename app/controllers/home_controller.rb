class HomeController < ApplicationController
  def index
    @top15 = Maintainer.top15
  end

  def groups_list
    @groups = Group.find_groups_in_sisyphus
  end

  def bygroup
    @group = params[:group]
    @group = @group + '/' + params[:group2] if !params[:group2].nil?
    @group = @group + '/' + params[:group3] if !params[:group3].nil?

    @srpms = Srpm.where(:group => @group, :branch => 'Sisyphus', :vendor => 'ALT Linux').paginate(:page => params[:page], :per_page => 100)
  end

  def packagers_list
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus
    @teams       = Maintainer.find_all_teams_in_sisyphus
  end

end
