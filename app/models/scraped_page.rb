class ScrapedPage < ApplicationRecord
    belongs_to :user
    has_many :links, dependent: :destroy

    enum :status, [:pending, :processing, :completed, :failed ], default: :pending, validate: true

    validates :url, presence: true
    validate :url_must_be_valid

    after_update_commit -> {
        broadcast_replace_to "scraped_pages_user_#{user_id}"
    }

    private

    def url_must_be_valid
        uri = URI.parse(url)
        unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
            errors.add(:url, 'must be a valid HTTP/HTTPS URL')
        end
    rescue URI::InvalidURIError
        errors.add(:url, 'is not a valid URI')
    end

end
