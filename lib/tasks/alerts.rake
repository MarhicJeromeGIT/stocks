namespace :alerts do
  desc "Go through every alerts and check if they should be triggered"
  task check: :environment do
    Alert.active.each do |alert|
      alert.check
    end
  end

end
