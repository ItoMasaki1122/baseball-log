class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.string :place
      t.string :enemy
      t.string :result
      t.string :topic
      t.text :content

      t.timestamps
    end
  end
end
