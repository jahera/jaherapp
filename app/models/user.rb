class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include AvatarUploader::Attachment(:avatar)

  validates :first_name, :last_name, :contact_no, :dob, :avatar, :organization_id, presence: true
end
