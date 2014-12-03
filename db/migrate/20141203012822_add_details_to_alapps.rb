class AddDetailsToAlapps < ActiveRecord::Migration
  def change
    remove_column :alapps, :local_country, :integer
    add_column :alapps, :local_country, :string
  end
end
