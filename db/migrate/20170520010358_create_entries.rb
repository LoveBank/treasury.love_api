class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.text :content
      t.datetime :occurred_on
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
