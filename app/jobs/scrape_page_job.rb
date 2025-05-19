class ScrapePageJob < ApplicationJob
  queue_as :default

  def perform(scraped_page_id)
    scraped_page = ScrapedPage.find(scraped_page_id)
    scraped_page.processing!

    ScraperService.new(scraped_page).call
  end
end
