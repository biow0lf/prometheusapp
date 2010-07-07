class Srpm < ActiveRecord::Base
  validates_presence_of :branch, :vendor, :filename, :name, :version, :release
end
