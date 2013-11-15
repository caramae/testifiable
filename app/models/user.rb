class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :email
  validates_uniqueness_of :name



  has_many :enrolls
  has_many :experiments, through: :enrolls


  def enrolled_experiments
    exp_ids = Enroll.select('experiment_id').where('user_id=?', self.id)
    experiments = Experiment.where(id: exp_ids)

    return experiments
  end

  def managed_experiments
    experiments = Experiment.where('author=?', self.id)
    return experiments
  end


end
