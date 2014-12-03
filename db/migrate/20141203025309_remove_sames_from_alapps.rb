class RemoveSamesFromAlapps < ActiveRecord::Migration
  def change
    remove_column :alapps, :same, :boolean
  end
end
