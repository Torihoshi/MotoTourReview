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
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
