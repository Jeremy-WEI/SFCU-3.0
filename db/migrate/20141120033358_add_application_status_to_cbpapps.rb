class AddApplicationStatusToCbpapps < ActiveRecord::Migration
  def change
    add_column :cbpapps, :application_status, :string, default: 'Unprocessed'
  end
end
