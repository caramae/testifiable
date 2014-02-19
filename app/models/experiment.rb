class Experiment < ActiveRecord::Base
  has_many :effects, :dependent => :destroy
  has_many :outcomes, :dependent => :destroy
  has_many :enrolls, :dependent => :destroy
  has_many :datapoints, :dependent => :destroy
  has_many :users, through: :enrolls

  accepts_nested_attributes_for :outcomes, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  validates_numericality_of :timeframe, :only_integer =>true, :greater_than_or_equal_to =>0, :message => "Invalid duration"
  validates_presence_of :action, :control, :category
  validates_uniqueness_of :action
  validate :validate_outcomes

  def validate_outcomes
    errors.add(:outcomes, "are missing") if outcomes.length < 1
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

  def can_reenroll(user_id)
    return !first_enrollment(user_id) && permits_enrollment(user_id)
  end

  def count_datapoints(assigned_action, complied)
    return Datapoint.where(experiment_id: self.id, compliance: complied, iv_value: assigned_action).count
  end

  def get_avg_val(assigned_action, complied)
    datapoints = Datapoint.where(experiment_id: self.id, compliance: complied, iv_value: assigned_action)
    if datapoints.empty?
      return 0
    else
      return 5
      sum = 0
      datapoints.each do |datapoint|
        sum = sum + datapoint.value
      end
      return sum / datapoints.count
      #return datapoints.inject{ |sum, el| sum + el.value } / datapoints.count
      #return mean(datapoints.value)
    end
  end

  def has_any_init_values
    return outcomes.any? {|outcome| outcome.has_init_value}
  end

  def needs_init_value(user_id)
    return outcomes.take_while{|outcome| outcome.has_init_value}.count > 0 && get_enroll(user_id).status == -2
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
