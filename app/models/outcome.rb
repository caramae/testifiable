class Outcome < ActiveRecord::Base
  belongs_to :experiment
  validates_uniqueness_of :name, :scope => [:experiment_id]
end
