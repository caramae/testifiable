class Experiment < ActiveRecord::Base
  has_many :outcomes, :dependent => :destroy
  has_many :enrolls, :dependent => :destroy
  has_many :datapoints, :dependent => :destroy
  has_many :users, through: :enrolls
  validates_numericality_of :timeframe, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "Invalid duration"
  #validates_presence_of :action, :control
  #validates_uniqueness_of :action
  #validate :validate_outcomes
  accepts_nested_attributes_for :outcomes, :allow_destroy => true#, :reject_if => lambda { |a| a[:name].blank? },

  def validate_outcomes
    errors.add(:outcomes, "too few outcomes") if outcomes.length < 1
  end

  def is_enrolled(user_id)
    enrolls = Enroll.where('user_id=? and experiment_id = ? and is_active = ?', user_id, self.id, true)
    if enrolls && enrolls.count>0
      status = true
    else
      status = false
    end
    return status
  end
  def enrolled_status(user_id)
    enrolls = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    if enrolls && enrolls.count>0
      return enrolls[0].status
    end
    return 0
  end

  def first_enrollment(user_id)
    enroll = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    return enroll.empty?
  end

  def permits_enrollment(user_id)
    enroll = Enroll.where('user_id=? and experiment_id = ?', user_id, self.id)
    return enroll.empty? || enroll[0].status > 0 || (enroll[0].status == -1 && enroll[0].next_time <= DateTime.now)
  end

  def count_datapoints(assigned_action, complied)
    return Datapoint.where(experiment_id: self.id, compliance: complied, iv_value: assigned_action).count
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

  def get_next_time
    if timeinterval == '1'
      return DateTime.now + 1.hour
    elsif timeinterval == '2'
      return DateTime.now + 1.day
    else
      return DateTime.now
    end
  end
end
