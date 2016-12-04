namespace :schedule do
  desc "Send out scheduled prompts"
  task prompt: :environment do
    Schedulers::Prompt.run
  end

  desc "Send out scheduled summaries"
  task summary: :environment do
    Schedulers::Summary.run
  end
end
