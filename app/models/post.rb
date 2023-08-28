# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  address      :string
#  comment      :text             not null
#  favorite     :integer          default(0)
#  is_private   :boolean          default(FALSE), not null
#  latitude     :float
#  longitude    :float
#  spot_name    :string           not null
#  star         :float
#  title        :string           not null
#  visited_date :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :integer          not null
#  user_id      :integer          not null
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  user_id      (user_id => users.id)
#
class Post < ApplicationRecord
  # Map用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :spot_name, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 20 }
  validates :comment, presence: true, length: { maximum: 255 }
  validates :visited_date, presence: true
  validates :category_id, presence: true
  validates :is_private, inclusion: { in: [true, false] }
  validate :image_type

  def get_image
    (image.attached?) ? image : "no_image.png"
  end

  def favorited_by?(user)
     favorites.exists?(user_id: user.id)
  end

  def formatted_address
    address.gsub(/〒.*? /, '').gsub("日本、", '')
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "category_id", "comment", "created_at", "favorite", "id", "is_private", "latitude", "longitude", "spot_name", "star", "title", "updated_at", "user_id", "visited_date"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "comments", "favorites", "image_attachment", "image_blob", "user"]
  end


  private


  def image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'はJPEGまたはPNG形式でアップロードしてください')
    elsif image.attached? && image.blob.byte_size > 5.megabytes
      errors.add(:image, 'のファイルサイズが大きすぎます（最大5MBまで）')
    end
  end

end
