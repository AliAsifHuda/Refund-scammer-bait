class User1 < ApplicationRecord
  has_secure_password

  has_many :accounts

  validates :username, presence:true,
                       length:{minimum:4, maximum:30},
                       uniqueness:{case_sensitive:false}
  validates :password, presence:true, length:{minimum: 6}
  before_save :downcase_username

  def User1.digest(passphrase)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  BCrypt::Password.create(password, cost: cost)
  end

  private
  def downcase_username()
    self.username = username.downcase
  end
end
