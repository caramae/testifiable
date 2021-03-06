class Datapoint < ActiveRecord::Base
  belongs_to :experiment
  validates_presence_of :value

  def compliant
    if compliance == true
      return 1
    else
      return 0
    end
  end

  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
  		csv << column_names
  		all.each do |datapoint|
  			csv << datapoint.attributes.values_at(*column_names)
  		end
  	end
  end

  def self.import(file)
  	CSV.foreach(file.path, headers: true) do |row|
      Datapoint.create! row.to_hash
  		#datapoint = find_by_id(row["id"]) || new
  		#datapoint.attributes = row.to_hash.slice(:value, :value2, :compliance)
  		#datapoint.save!
  	end
  end
end