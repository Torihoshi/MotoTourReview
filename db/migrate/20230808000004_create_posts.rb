class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.bigint :user_id,                         null: false
      t.bigint :category_id,                     null: false
      t.string     :spot_name,                   null: false
      t.string     :title,                       null: false
      t.text       :comment,                     null: false
      t.integer    :favorite,                                 default: 0
      t.date       :visited_date,                null: false
      t.boolean    :is_private,                  null: false, default: false
      t.string     :address
      t.float      :latitude
      t.float      :longitude
      t.float      :star

      t.timestamps
    end

    add_foreign_key "posts", "users"
    add_foreign_key "posts", "categories"
  end
end
