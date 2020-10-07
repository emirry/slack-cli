require 'dotenv'

class Recipient
  attr_reader :slack_id, :name

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def self.get(path)
    base_url = "https://slack.com/api/"
    method_url = base_url + path

  response = HTTParty.get(method_url, query: {
    token: ENV['SLACK_TOKEN'],
    format: 'json'
  }
  )
  end

  def self.list_all(path)
    self.get(path)

    response

  end

  def self.list_all(path)
    self.get(path)
    tp response['members'], 'id', 'name', 'real_name'
  end


end