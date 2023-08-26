# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bike_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  introduction           :text
#  is_deleted             :boolean          default(FALSE), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 16 }

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      random_password = SecureRandom.urlsafe_base64(6) # パスワードの長さをさらに短縮
      user.password = random_password
      user.name = "ゲストユーザー"
    end
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : "user-icon.png"
  end

  def remember_me
    true
  end
end
