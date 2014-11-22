class AddApplicationStatusToUlapps < ActiveRecord::Migration
  def change
    add_column :ulapps, :application_status, :string, default: "Unprocessed"
  end
end
