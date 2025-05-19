class CreateScrapedPages < ActiveRecord::Migration[8.0]
  def change
    create_table :scraped_pages do |t|
      t.integer :user_id
      t.string :url
      t.string :title
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
