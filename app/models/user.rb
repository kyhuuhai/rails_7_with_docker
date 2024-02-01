class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  before_create :generate_uid

  enum role: [:member, :admin]

  def generate_uid
    self.uid = SecureRandom.uuid
  end

  def self.ransackable_attributes(auth_object = nil)
    ["email", "fullname", "username", "id","created_at"]
  end
end
