class Repocop < ActiveRecord::Base
  validates_presence_of :name, :version, :release, :arch, :srcname, :srcversion, :srcrel, :testname, :status
end
