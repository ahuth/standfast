desc "Send out scheduled summaries"
namespace :schedule do
  task :summary => :environment do
    Rails.logger.info("Scheduling summaries")
    Schedulers::Summary.run
    Rails.logger.flush
  end
end
