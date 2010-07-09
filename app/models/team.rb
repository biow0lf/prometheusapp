class Team < ActiveRecord::Base
  validates_presence_of :name, :login, :branch, :vendor, :leader
end
