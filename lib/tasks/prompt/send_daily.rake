desc "Send the daily prompt email to every team"
namespace :prompt do
  task :daily => :environment do
    Team.find_each do |team|
      PromptMailer.daily_status_email(team).deliver
    end
  end
end
