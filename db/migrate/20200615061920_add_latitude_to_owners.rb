class AddLatitudeToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :activity_area, :string
    add_column :owners, :user_status, :integer, null: false, default: 0
    
  end
end
