require 'open-uri'
require 'nokogiri'

class ScraperService
  def initialize(scraped_page)
    @scraped_page = scraped_page
  end

  def call
    html = URI.open(@scraped_page.url, open_timeout: 10, read_timeout: 15).read
    doc = Nokogiri::HTML(html)

    @scraped_page.update(title: doc.at_css("title")&.text.to_s.strip, status: :completed)

    links = doc.css("a[href]").map do |a|
      href = a["href"].to_s.strip
      name = a.text.strip
      
      next if href.blank? || name.blank?

      @scraped_page.links.build(href: href, name: name)
    end

    @scraped_page.links.each(&:save!) if links.any?
  rescue => e
    @scraped_page.update(status: :failed, error_message: e.message)
    Rails.logger.error "Failed to scrape #{@scraped_page.url}: #{e.message}"
  end
end
