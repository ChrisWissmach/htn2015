class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :category
      t.text :entered

      t.timestamps null: false
    end
  end
end
