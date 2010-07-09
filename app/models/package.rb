class Package < ActiveRecord::Base
  validates_presence_of :vendor, :branch, :filename, :sourcepackage, :name, :version, :release, :size
end
