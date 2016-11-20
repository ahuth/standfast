desc "Send out scheduled prompts"
namespace :schedule do
  task :prompt => :environment do
    Rails.logger.info("Scheduling prompts")
    Schedulers::Prompt.run
    Rails.logger.flush
  end
end
