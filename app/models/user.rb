class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_uid

  enum role: [:member, :admin]
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 20 }
  validates :fullname, presence: true, length: { minimum: 6, maximum: 20 }

  def generate_uid
    self.uid = SecureRandom.uuid
  end

  def self.ransackable_attributes(auth_object = nil)
    ["email", "fullname", "username", "id", "created_at"]
  end
end
