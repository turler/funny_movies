class AddVideoAttributesToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :embed_url, :string
    add_column :movies, :author, :string
  end
end
