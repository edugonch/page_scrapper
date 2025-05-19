class AddErrorMessageToScrapedPages < ActiveRecord::Migration[8.0]
  def change
    add_column :scraped_pages, :error_message, :text
  end
end
