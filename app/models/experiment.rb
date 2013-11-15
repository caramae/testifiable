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

end
