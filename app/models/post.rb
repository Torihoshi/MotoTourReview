# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  favorite     :integer          default(0)
#  is_private   :boolean          default(FALSE), not null
#  name         :string           not null
#  post_comment :text             not null
#  post_title   :string           not null
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
end
