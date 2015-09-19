class AddIsActiveToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :is_active, :bool
  end
end
