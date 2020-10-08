require 'httparty'
require 'dotenv'
require_relative 'recipient'
require 'table_print'


Dotenv.load

class User < Recipient
  attr_reader :name, :slack_id, :real_name
              # :status_text, :status_emoji

  def initialize(name, slack_id, real_name)
    super(name, slack_id)
    @real_name = real_name
    # @status_text
    # @status_emoji
  end

  def self.endpoint_path
    return 'users.list'
  end

  def self.response_key
    return 'members'
  end

  def self.from_response_hash(record_hash)
    return User.new(record_hash['name'], record_hash['id'], record_hash['real_name'])
  end

  def to_details
    return "-- Details -- \nName: #{name}, Slack ID: #{slack_id}, Real Name: #{real_name}"
  end
end
