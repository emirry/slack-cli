# require_relative 'workspace'
require 'dotenv'

class Recipient
  class InvalidAPIError < StandardError; end

  attr_reader :name, :slack_id

  def initialize(name, slack_id)
    @name = name
    @slack_id = slack_id
  end

  def self.run_get_request(path)
    base_url = 'https://slack.com/api/'
    method_url = base_url + path

    response = HTTParty.get(method_url, query: {
    token: ENV['SLACK_TOKEN'],
    format: 'json'
  }
  )

    unless response.code == 200
      raise InvalidAPIError, "Something went wrong!"
    end

    return response
  end

  def self.list_all
    response = self.run_get_request(endpoint_path)
    return response[response_key].map { |record_hash| from_response_hash(record_hash) }
  end

end