desc "Send the daily prompt email to every team"
namespace :prompt do
  task :daily => :environment do
    today = Date.today
    if !today.sunday? && !today.monday?
      Team.find_each do |team|
        PromptMailer.daily_status_email(team).deliver_later
      end
    end
  end
end
