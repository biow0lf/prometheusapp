namespace :prometheusapp do
  namespace :sisyphus do

    desc "Import RPM groups for Sisyphus to database"
    task :groups => :environment do
    require 'open-uri'
      puts Time.now.to_s + ": import RPM groups for Sisyphus to database"
      Group.update_from_gitalt 'http://git.altlinux.org/gears/r/rpm.git?p=rpm.git;a=blob_plain;f=GROUPS', 'ALT Linux', 'Sisyphus'
      puts Time.now.to_s + ": end"
    end

  end
end