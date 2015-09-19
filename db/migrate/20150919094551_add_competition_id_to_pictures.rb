class AddCompetitionIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :competition_id, :int
  end
end
