class AddLatitudeToAdClients < ActiveRecord::Migration[5.2]
  def change
    add_column :ad_clients, :longitude, :float
  end
end
