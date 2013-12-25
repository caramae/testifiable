class Experiment < ActiveRecord::Base
  #has_many :outcomes, :dependent => :destroy
  #has_many :outcomes, :dependent => :destroy
  has_many :enrolls, :dependent => :destroy
  has_many :datapoints, :dependent => :destroy
  has_many :users, through: :enrolls
  #validates_presence_of :action, :control, :outcome, :unit
  #validates_uniqueness_of :action
  #validates_numericality_of :timeframe, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "Invalid duration"
  #accepts_nested_attributes_for :datapoints, :reject_if => lambda { |a| a[:content].blank? }

  def is_enrolled(user_id)
    enrolls = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    if enrolls && enrolls.count>0
      status = true
    else
      status = false
    end
    return status
  end
  def enrolled_status(user_id)
    enrolls = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    if enrolls
      if enrolls.count>0
        status = enrolls[0].randomize
      else
        status = 0
      end
    else
      status = 0
    end
    return status
  end
end
