# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_favorites_on_post_id  (post_id)
#  index_favorites_on_user_id  (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :user_id

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "post_id", "updated_at", "user_id"]
  end

end
