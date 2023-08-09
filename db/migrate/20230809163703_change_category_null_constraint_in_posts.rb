class ChangeCategoryNullConstraintInPosts < ActiveRecord::Migration[6.1]
  def up
    change_column_null :posts, :category_id, true
  end

  def down
    change_column_null :posts, :category_id, false
  end
end
