class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :owner_id, null: false
      t.integer :ad_id, null: false
      t.timestamps
    end
  end
end