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
    raise ArgumentError.new, "Sorry! There are 0 users" if users.length.zero?
  end

  def validate_channel?(channels)
    raise ArgumentError.new, "Sorry! channels couldn't be loaded" if channels.nil?
    raise ArgumentError.new, "Sorry! There are 0 channels" if channels.length.zero?
  end

  def select_user(user_to_select)
    if @users.any? { |user| user.name == user_to_select }
      @selected = @users.find { |user| user.name == user_to_select }
    elsif @users.any? { |user| user.slack_id == user_to_select }
      @selected = @users.find { |user| user.slack_id == user_to_select }
    end
    return @selected
  end

  def select_channel(channel_to_select)
    if @channels.any? { |channel| channel.name == channel_to_select }
      @selected = @channels.find { |channel| channel.name == channel_to_select }
    elsif @channels.any? { |channel| channel.slack_id == channel_to_select }
      @selected = @channels.find { |channel| channel.slack_id == channel_to_select }
    end
    return @selected
  end

  def return_selected
    return @selected
  end

  def to_details
    return @selected.to_details
  end

  def no_selection?
    @selected.nil?
  end

  def send_message(selected_slack_id, user_response)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.post(url,
            headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
            body: {
            token: ENV["SLACK_TOKEN"],
            channel: selected_slack_id,
            text: user_response
        })

    unless response.code == 200
      raise InvalidAPIError, "Error! Status code: #{response.code}"
    end

    unless response["ok"]
      raise InvalidAPIError, "Your message #{user_response} did not go through. Error: #{response["error"]}"
    end
    return true
  end

  def channel_doesnt_exist?(channel_to_select)
    return true unless (@channels.any? { |channel| channel.name == channel_to_select || channel.slack_id == channel_to_select })
  end

  def user_doesnt_exist?(user_to_select)
    return true unless (@users.any? { |user| user.name == user_to_select || user.slack_id == user_to_select })
  end
end