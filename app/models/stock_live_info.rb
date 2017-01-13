class StockLiveInfo < ApplicationRecord
  belongs_to :stock
  
  validates :stock, presence: true
  
  # Update the infos if it's more than 5 minutes old
  after_find :update_live_info
  
  # Get the info from an outside live info feed, parse them and store them
  # TODO: add an adapter in between so i can use multiple feed, for when they shut this one.
  def update
    # Ohohoh. If the values don't change, the updated_at is not updated.
    # Use .touch method to set the update_at time, otherwise we poll the API everytime
    # We access the value :(
    self.touch
    p "calling update" 
    symbol = self.stock.code
    url = "http://lesechos-bourse-fo-cdn.wlb.aw.atos.net/streaming/cours/getCours?code=#{symbol}&place=XPAR&codif=ISIN"
    response = HTTParty.get(url)

    success = false
    if response.code == 200
      success = true
      j = JSON.parse(response.body)
      data = j["cotation"]
      p data
      # Fill and store the live feed data
      self.value_now  = parse_float(data["valorisation"])
      self.value_open = parse_float(data["open"])
      self.value_high = parse_float(data["high"])
      self.value_low  = parse_float(data["low"])
      return self.save
    end
    return success
  end
  
  
    def parse_float(str)
      str.try(:match, /(\d+[,.]\d+)/) do |m|
        return m[0].tr(",",".").to_f
      end
      return nil
    end
    
    def update_live_info
      if self.updated_at < 5.minute.ago
        self.update
      end
    end
end
