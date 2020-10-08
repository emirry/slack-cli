require 'dotenv'

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.run_get_request(path)
    base_url = 'https://slack.com/api/'
    method_url = base_url + path

  response = HTTParty.get(method_url, query: {
    token: ENV['SLACK_TOKEN'],
    format: 'json'
  }
  )
    return response

  end

  def self.list_all
    response = self.run_get_request(endpoint_path)
    return response[response_key].map { |record_hash| from_response_hash(record_hash) }

    # elsif path == 'conversations.list'
    #   tp response['channels'], 'name', 'purpose', 'num_members', 'id'
  end

end