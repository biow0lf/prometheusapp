class ApiController < ApplicationController
  respond_to :html, :xml, :json
  layout nil

  def count
    @counter = Srpm.where(:branch => params[:branch], :vendor => params[:vendor]).count
  end

end
