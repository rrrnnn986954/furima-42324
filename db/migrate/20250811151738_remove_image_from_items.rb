class RemoveImageFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :image, :string
  end
end

