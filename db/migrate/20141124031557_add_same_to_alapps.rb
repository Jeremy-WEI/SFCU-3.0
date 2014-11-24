class AddSameToAlapps < ActiveRecord::Migration
  def change
    add_column :alapps, :same, :integer
  end
end
