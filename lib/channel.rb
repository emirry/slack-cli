require 'httparty'
require 'dotenv'
require_relative 'recipient'
require 'table_print'

class Channel < Recipient
  attr_reader :name, :slack_id, :topic, :member_count

  def initialize(name, slack_id, topic, member_count)
    super(name, slack_id)
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
    return Channel.new(record_hash['name'], record_hash['id'], record_hash['topic']['value'], record_hash['num_members'])
  end

  def to_details
    return "-- Details --\nName: #{name}, Slack ID: #{slack_id}, Topic: #{topic}, Member Count: #{member_count.to_s}"
  end
end