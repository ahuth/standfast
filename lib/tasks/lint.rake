if !Rails.env.production?
  require "colorize"
  require "rubocop/rake_task"

  namespace :lint do
    RuboCop::RakeTask.new(:ruby)

    desc "Run eslint"
    task :js do
      puts "Running eslint..."
      sh "yarn run lint-js" do |ok|
        puts Colorize.green("No Javascript issues") + " detected" if ok
      end
    end

    desc "Run stylelint"
    task :style do
      puts "Running stylelint..."
      sh "yarn run lint-style" do |ok|
        puts Colorize.green("No style issues") + " detected" if ok
      end
    end
  end

  desc "Run Ruby and Javascript linters"
  task :lint => ["lint:ruby", "lint:js", "lint:style"]
end
