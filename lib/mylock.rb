class Mylock
  @pid_filename = "#{RAILS_ROOT}/tmp/prometheusapp_cron.pid"

  def self.lock(task)
    if File.exists?(@pid_filename) && system("kill -0 #{File.read(@pid_filename).to_i}")
      puts "Task already running (#{task})"
      exit
    else
      File.open(@pid_filename,'w') {|f| f.write(Process.pid) }
    end
  end

  def self.unlock
    File.unlink(@pid_filename) rescue nil
  end

end
