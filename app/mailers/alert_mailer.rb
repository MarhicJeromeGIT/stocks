class AlertMailer < ApplicationMailer
    def alert_triggered_email(alert)
    @alert = alert
    dropped_or_reach = @alert.alert_type == Alert::TYPE_LOWER_THAN ? "dropped below" : "reached"
    subject = "#{alert.stock.name} value #{dropped_or_reach} #{@alert.target_value}"
    # Send the alert to the user email if there is one, otherwise to the registered contact email
    mail(to: @alert.user.try(:email) || @alert.contact, subject: subject)
  end
end
