module ScrapedPagesHelper
    def status_color(status)
        case status.to_s
        when "pending" then "text-yellow-500"
        when "processing" then "text-blue-500"
        when "completed" then "text-green-600"
        when "failed" then "text-red-600"
        else "text-gray-500"
        end
    end

    def display_url(url)
        uri = URI.parse(url)
        "#{uri.host}#{uri.path}".truncate(60)
    rescue URI::InvalidURIError
        url.truncate(60)
    end
end
