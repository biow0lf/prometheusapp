class TeamController < ApplicationController

  def info
    @team = Maintainer.first :conditions => {
                               :login => '@' + params[:name].downcase,
                               :team => 'yes' }
    @acls = Acl.all :conditions => {
                      :login => '@' + params[:name].downcase,
                      :branch => 'Sisyphus',
                      :vendor => 'ALT Linux' }

    if @team != nil
      @leader = Team.find_by_sql(['SELECT teams.login, maintainers.name
                                   FROM teams, maintainers
                                   WHERE maintainers.login = teams.login
                                   AND teams.name = ?
                                   AND teams.branch = ?
                                   AND teams.vendor = ?
                                   AND leader = \'yes\'
                                   LIMIT 1', '@' + params[:name], 'Sisyphus', 'ALT Linux' ])

      @members = Team.find_by_sql(['SELECT teams.login, maintainers.name
                                    FROM teams, maintainers
                                    WHERE maintainers.login = teams.login
                                    AND teams.name = ?
                                    AND teams.branch = ?
                                    AND teams.vendor = ?', '@' + params[:name], 'Sisyphus', 'ALT Linux' ])
    else
      render :action => "nosuchteam"
    end
  end

end
