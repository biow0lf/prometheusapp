namespace :prometheusapp do
desc "Seed"
task :seed => :environment do

  Mylock.lock("seed")

  puts Time.now.to_s + ": seed"

  Maintainer.create(:name => 'Nobody', :email => 'noboby@altlinux.org', :login => '@nobody', :team => 'yes')

  Maintainer.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => 'no')
  Maintainer.create(:name => 'Alexey Tourbin', :email => 'at@altlinux.org', :login => 'at', :team => 'no')
  Maintainer.create(:name => 'Alexey I. Froloff', :email => 'raorn@altlinux.org', :login => 'raorn', :team => 'no')
  Maintainer.create(:name => 'Eugeny A. Rostovtsev', :email => 'real@altlinux.org', :login => 'real', :team => 'no')
  Maintainer.create(:name => 'Alexey Rusakov', :email => 'ktirf@altlinux.org', :login => 'ktirf', :team => 'no')
  Maintainer.create(:name => 'Alex Gorbachenko', :email => 'algor@altlinux.org', :login => 'algor', :team => 'no')
  Maintainer.create(:name => 'Andriy Stepanov', :email => 'stanv@altlinux.org', :login => 'stanv', :team => 'no')
  Maintainer.create(:name => 'Anton Farygin', :email => 'rider@altlinux.org', :login => 'rider', :team => 'no')
  Maintainer.create(:name => 'Igor Muratov', :email => 'migor@altlinux.org', :login => 'migor', :team => 'no')
  Maintainer.create(:name => 'Mihail A. Pluzhnikov', :email => 'amike@altlinux.org', :login => 'amike', :team => 'no')
  Maintainer.create(:name => 'Pavel V. Solntsev', :email => 'p_solntsev@altlinux.org', :login => 'p_solntsev', :team => 'no')
  Maintainer.create(:name => 'Serge Ryabchun', :email => 'sr@altlinux.org', :login => 'sr', :team => 'no')
  Maintainer.create(:name => 'Yurkovsky Andrey', :email => 'anyr@altlinux.org', :login => 'anyr', :team => 'no')
  Maintainer.create(:name => 'Mikerin Sergey', :email => 'mikcor@altlinux.org', :login => 'mikcor', :team => 'no')
  Maintainer.create(:name => 'Alexey Lokhin', :email => 'warframe@altlinux.org', :login => 'warframe', :team => 'no')
  Maintainer.create(:name => 'Alexey Shabalin', :email => 'shaba@altlinux.org', :login => 'shaba', :team => 'no')
  Maintainer.create(:name => 'Valery Pipin', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => 'no')
  Maintainer.create(:name => 'Pavel Boldin', :email => 'bp@altlinux.org', :login => 'bp', :team => 'no')
  Maintainer.create(:name => 'Ruslan Hihin', :email => 'ruslandh@altlinux.org', :login => 'ruslandh', :team => 'no')
  Maintainer.create(:name => 'Sergey Lebedev', :email => 'barabashka@altlinux.org', :login => 'barabashka', :team => 'no')
  Maintainer.create(:name => 'Konstantin Pavlov', :email => 'thresh@altlinux.org', :login => 'thresh', :team => 'no')
  Maintainer.create(:name => 'Aeliya Grevnyov', :email => 'gray_graff@altlinux.org', :login => 'gray_graff', :team => 'no')
  Maintainer.create(:name => 'Aleksandr Blokhin', :email => 'sass@altlinux.org', :login => 'sass', :team => 'no')

  puts Time.now.to_s + ": end"

  Mylock.unlock

end
end
