# Preview all emails at http://localhost:3000/rails/mailers/prompt
class SummaryPreview < ActionMailer::Preview
  def daily_summary_email
    SummaryMailer.daily_summary_email(Team.first)
  end
end
