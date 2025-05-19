class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.references :scraped_page, null: false, foreign_key: true
      t.text :href
      t.text :name

      t.timestamps
    end
  end
end
