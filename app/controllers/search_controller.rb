class SearchController < ApplicationController

  def index
    search = params[:search]
    search = params[:request]
    search = '%' + search + '%'
    # fix this for "some things" search
    @srpms = Srpm.where(
                        (:name.matches % search) |
                        (:summary.matches % search) |
                        (:description.matches % search)
                       ).where(:branch => 'Sisyphus', :vendor => 'ALT Linux')
  end

end
