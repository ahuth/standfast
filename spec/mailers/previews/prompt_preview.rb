# Preview all emails at http://localhost:3000/rails/mailers/prompt
class PromptPreview < ActionMailer::Preview
  def daily_status_email
    PromptMailer.daily_status_email(Team.first)
  end
end
