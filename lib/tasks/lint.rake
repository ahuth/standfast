require "rubocop/rake_task"

namespace :lint do
  RuboCop::RakeTask.new

  desc "Run eslint"
  task :eslint do
    sh "node_modules/.bin/eslint app/assets/javascripts/**/*.js spec/javascripts/**/*.js"
  end
end

desc "Run Ruby and Javascript linters"
task :lint do
  Rake::Task["lint:rubocop"].invoke
  Rake::Task["lint:eslint"].invoke
end
