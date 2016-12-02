namespace :stocks do
  require 'csv'
  
  desc "Import the stocks from the french CAC40"
  task import_cac: :environment do
    path = Rails.root.join('lib', 'assets', 'data', 'libelles.csv')
    File.open(path) do |f|
      csv_text = f.read
      csv = CSV.parse(csv_text, :headers => true, :col_sep => ";")
      csv.each do |row|
        
        Stock.find_or_create_by(name: row["nom"]) do |stock|
          stock.code = row["ISIN"]
          stock.save
        end
        
        #row["ISIN"]
        #p row["nom"]
      end
    end
  end

end
