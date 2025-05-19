class Link < ApplicationRecord
  belongs_to :scraped_page

  validates :href, presence: true
end
