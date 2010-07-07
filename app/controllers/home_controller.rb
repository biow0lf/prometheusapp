class HomeController < ApplicationController
  def index
  end

  def groups_list
    @groups = Group.find_groups_in_sisyphus
  end

end
