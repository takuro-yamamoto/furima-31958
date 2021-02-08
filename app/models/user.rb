class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email,           uniqueness: true
  validates :nickname,        presence: true
  validates :last_name_full,  presence: true
  validates :first_name_full, presence: true
  validates :last_name_kana,  presence: true
  validates :first_name_kana, presence: true
  validates :birthday,        presence: true
end
