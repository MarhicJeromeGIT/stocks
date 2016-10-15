class AlertMailer < ApplicationMailer
    def alert_triggered_email(alert)
    @alert = alert
    dropped_or_reach = @alert.alert_type == Alert::TYPE_LOWER_THAN ? "dropped below" : "reached"
    subject = "#{alert.stock.name} value #{dropped_or_reach} #{@alert.target_value}"
    mail(to: @alert.contact, subject: subject)
  end
end
