class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user,     foreign_key: true, null: false, type: :bigint
      t.references :category, foreign_key: true, null: false, type: :bigint
      t.string     :spot_name,                   null: false
      t.string     :title,                       null: false
      t.text       :comment,                     null: false
      t.integer    :favorite,                                 default: 0
      t.date       :visited_date,                null: false
      t.boolean    :is_private,                  null: false, default: false
      t.timestamps
    end
  end
end
