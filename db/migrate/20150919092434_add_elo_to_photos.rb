class AddEloToPhotos < ActiveRecord::Migration
  def change
    add_column :pictures, :elo, :int
  end
end
