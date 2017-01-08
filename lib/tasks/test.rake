Rake::Task["test"].clear
Rake::Task["test:db"].clear

if !Rails.env.production?
  desc "Run all linters and tests"
  task :test => ["lint", "spec", "spec:javascripts"]
end
