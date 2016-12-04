namespace :spec do
  desc "Run the code examples in spec/javascripts"
  task :js do
    sh "yarn test -- --single-run" do
      # No op
    end
  end
end
