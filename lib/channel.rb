require 'httparty'
require 'dotenv'
require_relative 'recipient'
require 'table_print'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)

    @topic = topic
    @member_count = member_count
  end

  def self.endpoint_path
    return 'conversations.list'
  end

  def self.response_key
    return 'channels'
  end

  def self.from_response_hash(record_hash)
    return Channel.new(record_hash['id'], record_hash['name'], record_hash['topic']['value'], record_hash['num_members'])
  end

  #def details
  # return instnace of channel(record_hash['id'], record_hash['name'], record_hash['topic']['value'], record_hash['num_members'])
  #
end