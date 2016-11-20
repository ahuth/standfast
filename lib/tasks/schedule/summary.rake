desc "Send out scheduled summaries"
namespace :schedule do
  task :summary => :environment do
    Schedulers::Summary.run
  end
end
