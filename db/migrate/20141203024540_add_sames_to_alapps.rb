class AddSamesToAlapps < ActiveRecord::Migration
  def change
    remove_column :alapps, :same, :integer
    add_column :alapps, :same, :boolean
  end
end
