class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_secure_password
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }
  #validates :email, presence: true, uniqueness: true, email: true
  #validates :password, length: { minimum: 5 }

  has_many :enrolls
  has_many :experiments, through: :enrolls


  def enrolled_experiments
    exp_ids = Enroll.select('experiment_id').where(user_id: self.id, is_active: true)
    experiments = Experiment.where(id: exp_ids)
    return experiments
  end

  def managed_experiments
    experiments = Experiment.where('author=?', self.id)
    return experiments
  end
end