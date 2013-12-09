class Experiment < ActiveRecord::Base
  has_many :enrolls
  has_many :users, through: :enrolls


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
