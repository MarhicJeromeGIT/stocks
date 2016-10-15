class Alert < ApplicationRecord
  ALERT_STATUS = ["enabled", "triggered", "disabled"]
  ALERT_TYPES = ["value_smaller_than", "value_higher_than"]
  
  belongs_to :stock
  
  before_validation :set_alert_type

  validates :alert_type, :inclusion => {:in => Alert::ALERT_TYPES}
  validates :stock, presence: true
  validates :target_value, presence: true
  validates :contact, presence: true
  
  # Check if we should trigger the alert
  def check
    # don't trigger it twice
    #if self.stock.
  end
  
  private

    def set_alert_type
      unless self.alert_type
        # determine if we want the action to go up or down
        if self.stock.stock_live_info.value_low > self.target_value
          self.alert_type = "value_smaller_than"
        elsif self.stock.stock_live_info.value_high < self.target_value
          self.alert_type = "value_higher_than"
        else
          # Error: the target value is in between the [low,high] values of the day,
          # We can't create the alert.
          errors.add(:target_value, "can't be greater than total value")
        end
      end
    end
end
