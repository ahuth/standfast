desc "Send the daily prompt email to every team"
namespace :prompt do
  task :daily => :environment do
    Prompters::DailyPrompter.run
  end
end
