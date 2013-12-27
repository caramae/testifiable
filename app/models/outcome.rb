class Outcome < ActiveRecord::Base
  belongs_to :experiment
  #validates_presence_of :name
end
