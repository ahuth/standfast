class SummaryMailer < ApplicationMailer
  default from: "noreply@em.standfastapp.com"

  def daily_summary_email(team)
    @responses = team.responses.unhandled.includes(:seat)
    mail(to: team.seats.pluck(:email), subject: "Daily Summary")
  end
end
