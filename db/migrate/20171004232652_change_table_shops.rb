class ChangeTableShops < ActiveRecord::Migration[5.1]
  def change
    remove_column :shops, :api_key
    add_column :shops, :notify_url, :string
  end
end
