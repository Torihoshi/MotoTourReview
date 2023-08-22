class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :post, foreign_key: true, null: false, type: :bigint
      t.references :user, foreign_key: true, null: false, type: :bigint

      t.timestamps
    end
  end
end
