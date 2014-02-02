class Variable < ActiveRecord::Base
  belongs_to :experiment
  validates_uniqueness_of :name, :scope => [:experiment_id]
  #qualitative (e.g. color), discrete quantitative (e.g. on a scale of 1-5, ...), or continuous quantitative (e.g. weight)
end
