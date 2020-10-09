require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'recipient'
Dotenv.load

class Workspace < Recipient
  class InvalidAPIError < StandardError; end

  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil

    validate_user?(@users)
    validate_channel?(@channels)
  end

  def validate_user?(users)
    raise ArgumentError.new, "Sorry! Users couldn't be loaded" if users.nil?
    raise ArgumentError.new, "Sorry! There are 0 users" if users.length == 0
  end

  def validate_channel?(channels)
    raise ArgumentError.new, "Sorry! channels couldn't be loaded" if channels.nil?
    raise ArgumentError.new, "Sorry! There are 0 channels" if channels.length == 0
  end

  def select_user(user_to_select)
    @selected = @users.find { |user| user.name == user_to_select }
    return @selected
  end

  def select_channel(channel_to_select)
    @selected = @channels.find { |channel| channel.name == channel_to_select }
    return @selected
  end

  def to_details
    return @selected.to_details
  end

  def no_selection?
    @selected.nil?
  end

  def send_message(user_response)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.post(url,
            headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
            body: {
            token: ENV["SLACK_TOKEN"],
            channel: @selected.slack_id,
            text: user_response
        }
    )

    unless response.code == 200
      raise InvalidAPIError, "Error! Status code: #{response.code}"
    end #write test

    unless response["ok"]
      raise InvalidAPIError, "Your message #{user_response} did not go through. Error: #{response["error"]}"
    end
  end

end