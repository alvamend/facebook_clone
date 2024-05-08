class RemoveColumnFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :likes, :integer
  end
end
