notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"] do
  defaults channel: "#stocks",
           username: "notifier"
end

notifier.ping 'Initializing Stocks app'
