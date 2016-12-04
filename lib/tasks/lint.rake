require "rubocop/rake_task"
require "colorize"

namespace :lint do
  RuboCop::RakeTask.new(:ruby)

  desc "Run eslint"
  task :js do
    puts "Running eslint..."
    sh "yarn run lint" do |ok|
      puts Colorize.green("No Javascript issues") + " detected" if ok
    end
  end
end

desc "Run Ruby and Javascript linters"
task :lint => ["lint:ruby", "lint:js"]
