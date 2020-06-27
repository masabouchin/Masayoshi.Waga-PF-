class CreateApplicationHelpers < ActiveRecord::Migration[5.2]
  def change
    create_table :application_helpers do |t|

      t.timestamps
    end
  end
end
