namespace :prometheusapp do
desc "Import all gear repositories to database"
task :gear => :environment do
  require 'open-uri'

  Mylock.lock("gear")

  puts Time.now.to_s + ": import gear repositories to database"
  Gear.update_from_gitalt("http://git.altlinux.org/people-packages-list")
  puts Time.now.to_s + ": end"

  Mylock.unlock

end
end
