class PromptMailer < ApplicationMailer
  default from: "prompt@standfastapp.com"

  def daily_status_email(team)
    mail(to: team.seats.pluck(:email), subject: "What did you do today? [#{team.id}]")
  end
end
