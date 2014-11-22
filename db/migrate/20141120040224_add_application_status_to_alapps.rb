class AddApplicationStatusToAlapps < ActiveRecord::Migration
  def change
    add_column :alapps, :application_status, :string, default: "Unprocessed"
  end
end
