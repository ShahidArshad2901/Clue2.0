require 'net/http'
require 'json'

class QuestionService
  def self.endpoint_url
    # This is a dummy endpoint
    "https://mocki.io/v1/73c1fbf4-f97d-4d22-97b0-4e05cc393c67"
  end

  def self.fetch_data
    response = Net::HTTP.get(URI(endpoint_url))
    data = JSON.parse(response)
  end
end
