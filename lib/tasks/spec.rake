if !Rails.env.production?
  namespace :spec do
    desc "Run the code examples in spec/javascripts"
    task :javascripts do
      sh "yarn test" do |ok|
        # No-op
      end
    end
  end
end
