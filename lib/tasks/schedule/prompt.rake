desc "Send out scheduled prompts"
namespace :schedule do
  task :prompt => :environment do
    Schedulers::Prompt.run
  end
end
