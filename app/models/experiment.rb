class Experiment < ActiveRecord::Base
  #has_many :outcomes, :dependent => :destroy
  #has_many :outcomes, :dependent => :destroy
  has_many :enrolls, :dependent => :destroy
  has_many :datapoints, :dependent => :destroy
  has_many :users, through: :enrolls
  validates_numericality_of :timeframe, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "Invalid duration"
  #validates_presence_of :action, :control, :outcome, :unit
  #validates_uniqueness_of :action
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

  def permits(user_id)
    enroll = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    if enroll.empty?
      return true
    end
    return enroll[0].is_active
  end

  def get_enroll(user_id)
    enroll = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    return enroll[0]
  end

  def get_ending_time
    if timeframe_units == 'minutes'
      return DateTime.now + timeframe.minutes
    elsif timeframe_units == 'hours'
      return DateTime.now + timeframe.hours
    else
      return DateTime.now + timeframe.days
    end
  end
end
