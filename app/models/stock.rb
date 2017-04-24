require 'elasticsearch/model'

class Stock < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one :stock_live_info, autosave: true, dependent: :destroy
  
  after_initialize do |stock|
    create_stock_live_info if stock.new_record?
  end
  
  validates :name, presence: true
  validates :code, presence: true
  validates :stock_live_info, presence: true

  # helper to get the current value of the stock
  def value
    return self.stock_live_info.value_now
  end
  
  private
    def create_stock_live_info
      self.build_stock_live_info
    end
end
