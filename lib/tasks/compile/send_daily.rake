desc "Send the daily summary email to every team that needs it"
namespace :compile do
  task :daily => :environment do
    Compilers::DailyCompiler.run
  end
end
