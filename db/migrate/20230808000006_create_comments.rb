class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true, null: false, type: :bigint
      t.references :user, foreign_key: true, null: false, type: :bigint
      t.text       :comment,                 null: false

      t.timestamps
    end
  end
end