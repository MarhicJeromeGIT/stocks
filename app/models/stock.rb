class Stock < ApplicationRecord
  has_one :stock_live_info, autosave: true, dependent: :destroy
  
  before_validation :create_stock_live_info
  
  validates :name, presence: true
  validates :code, presence: true
  
  # helper to get the current value of the stock
  def value
    return self.stock_live_info.value_now
  end
  
  private
    def create_stock_live_info
      if self.new_record?
        self.build_stock_live_info
      end
    end
end
