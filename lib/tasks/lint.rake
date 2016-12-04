require "rubocop/rake_task"
require "colorize"

namespace :lint do
  RuboCop::RakeTask.new

  desc "Run eslint"
  task :eslint do
    puts "Running eslint..."
    sh "node_modules/.bin/eslint app/assets/javascripts/**/*.js spec/javascripts/**/*.js" do |ok|
      puts Colorize.green("No Javascript issues") + " detected" if ok
    end
  end
end

desc "Run Ruby and Javascript linters"
task :lint => ["lint:rubocop", "lint:eslint"]
