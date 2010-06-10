require 'open-uri'
require 'csv'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$KCODE="UTF8"

namespace :prometheusapp do
  namespace :sisyphus do
    desc "Import all bugs to database"
    task :bugs => :environment do
      Mylock.lock("bugs")
      puts Time.now.to_s + ": import bugs"
      Bug.update_bugs_from_bugzilla_alt("https://bugzilla.altlinux.org/buglist.cgi?ctype=csv")
      puts Time.now.to_s + ": end"
      Mylock.unlock
    end
  end
end

