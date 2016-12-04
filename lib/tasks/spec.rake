namespace :spec do
  desc "Run the code examples in spec/javascripts"
  task :js do
    sh "yarn test" do
      # No op
    end
  end
end

# Add the Javascript tests to the prerequisites of the existing `spec` task.
# This does not override it, but only adds the prerequisite.
task :spec => ["spec:js"]
