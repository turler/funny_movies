class AddAvailabilityToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :available, :boolean, defaul: false
  end
end
