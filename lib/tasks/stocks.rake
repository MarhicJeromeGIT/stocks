namespace :stocks do
  require 'csv'
  
  desc "Import the stocks from the french CAC40"
  task import_cac: :environment do
    path = Rails.root.join('lib', 'assets', 'data', 'libelles.csv')
    File.open(path) do |f|
      csv_text = f.read
      csv = CSV.parse(csv_text, :headers => true, :col_sep => ";")
      csv.each do |row|
        stock = Stock.where(name: row["nom"]).first_or_initialize do |stock|
          stock.code = row["ISIN"]
        end
        stock.save
      end
    end
  end

end
