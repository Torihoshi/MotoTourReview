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
#  visited_date :date             default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :integer          not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
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

  def get_image
    (image.attached?) ? image : "no_image.jpg"
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
