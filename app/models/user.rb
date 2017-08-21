class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trips, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end
