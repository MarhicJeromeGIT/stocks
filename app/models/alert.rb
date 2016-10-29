class Alert < ApplicationRecord
  belongs_to :user, optional: true

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
  
  scope :active, -> { where(status: STATUS_ACTIVE) }
  
  belongs_to :stock
  
  before_validation :set_alert_type
  after_initialize :set_alert_status
  
  validates :alert_type, :inclusion => {:in => Alert::ALERT_TYPES}
  validates :stock, presence: true
  validates :target_value, presence: true
  validate :contact_or_user 
  validates :status, :inclusion => {:in => Alert::ALERT_STATUS}
  
  # trigger the alert: change the status and send an email to the user
  def trigger
    AlertMailer.alert_triggered_email(self).deliver_now
    self.status = STATUS_TRIGGERED
    self.save
  end

  # Check if we should trigger the alert
  def check
    # don't trigger it twice
    return unless self.status == STATUS_ACTIVE
    
    # if we finally reached the value, trigger the alert
    if self.alert_type == TYPE_LOWER_THAN
      # I don't poll the values all the time, so we take the lowest value of the
      # day to compare with, not the current stock value, or we could miss some intra day variations.
      # The stock value fell below our target value, trigger the alert
      if self.target_value >= self.stock.stock_live_info.value_low
        self.trigger
      end
    elsif self.alert_type == TYPE_HIGHER_THAN
      # The stock value reached higher than our target value, trigger the alert
      if self.target_value <= self.stock.stock_live_info.value_high
        self.trigger
      end
    end
  end
  
  
  # Formatting helpers
  def display_target_value
    return target_value.to_s + " €"
  end
  
  private
    def contact_or_user
      unless contact || user
        errors.add(:contact, "The email must be set to send an alert !")
      end
    end
    
    def set_alert_type
      # TODO This is called every time we update the alert, but 
      # it should really be called at creation time only
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
