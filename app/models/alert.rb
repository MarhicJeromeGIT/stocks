class Alert < ApplicationRecord
  
  # Posible alert status
  STATUS_ACTIVE    = "active"    # The alert has been created and not triggered yet
  STATUS_TRIGGERED = "triggered" # The alert has been triggered, not active anymore
  STATUS_DISABLED  = "disabled"  # The user manually disabled the alert
  ALERT_STATUS = [STATUS_ACTIVE, STATUS_TRIGGERED, STATUS_DISABLED]
  
  # Possible alert types
  TYPE_LOWER_THAN   = "value_lower_than"
  TYPE_HIGHER_THAN  = "value_higher_than"
  TYPE_ERROR        = "error"
  ALERT_TYPES = [TYPE_LOWER_THAN, TYPE_HIGHER_THAN, TYPE_ERROR]
  
  belongs_to :stock
  
  before_validation :set_alert_type
  after_initialize :set_alert_status
  
  validates :alert_type, :inclusion => {:in => Alert::ALERT_TYPES}
  validates :stock, presence: true
  validates :target_value, presence: true
  validates :contact, presence: true
  validates :status, :inclusion => {:in => Alert::ALERT_STATUS}

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
          self.alert_type = TYPE_LOWER_THAN
        elsif self.stock.stock_live_info.value_high < self.target_value
          self.alert_type = TYPE_HIGHER_THAN
        else
          self.alert_type = TYPE_ERROR
          # Error: the target value is in between the [low,high] values of the day,
          # We can't create the alert.
          errors.add(:target_value, "(#{self.target_value}) should be outside the range [#{self.stock.stock_live_info.value_low},#{self.stock.stock_live_info.value_high}]")
        end
      end
    end
    
    def set_alert_status
      unless self.status
        self.status = STATUS_ACTIVE
      end
    end
end
