class Stock < ApplicationRecord
  has_one :stock_live_info
  
  before_create :create_stock_live_info
  
  validates :name, presence: true
  validates :code, presence: true
  
  # helper to get the current value of the stock
  def value
    return self.stock_live_info.value_now
  end
  
  private
    def create_stock_live_info
      self.build_stock_live_info
      true
    end
end
