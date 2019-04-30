class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.string :scoring
      t.string :map
      t.string :style
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
