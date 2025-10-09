namespace :users do
  desc 'Reset all users and reseed'
  task reset: :environment do
    User.destroy_all
    puts "All users destroyed at #{Time.current}"

    Rake::Task['db:seed'].invoke
    puts "Database reseeded at #{Time.current}"
  end
end
