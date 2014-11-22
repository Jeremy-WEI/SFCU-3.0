class AddApplicationStatusToMaapps < ActiveRecord::Migration
  def change
    add_column :maapps, :application_status, :string, default: 'Unprocessed'
  end
end
