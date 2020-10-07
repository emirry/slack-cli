require 'httparty'
require 'dotenv'
require_relative 'recipient'
require 'table_print'


Dotenv.load

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name)
    super(slack_id, name)
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
    return User.new(record_hash['id'], record_hash['name'], record_hash['real_name'])
  end
end

#record_hash['real_name']['value']
#
# dig helper method - stops looking once reaches nil within deep data structure. method of hash
