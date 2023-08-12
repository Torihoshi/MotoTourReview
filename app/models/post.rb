# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  comment      :text             not null
#  favorite     :integer          default(0)
#  is_private   :boolean          default(FALSE), not null
#  spot_name    :string           not null
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
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
