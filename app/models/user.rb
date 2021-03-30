class User < ApplicationRecord
  enum role: {admin: 0, supervisor: 1, trainee: 2}
  validates :name, presence: true,
   length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
   length: {maximum: Settings.user.email.max_length},
   format: {with: Settings.user.email.regex}
  validates :password, presence: true,
   length: {minimum: Settings.user.password.min_length}
  before_save ->{email.downcase!}
  has_secure_password

  def self.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end
end
