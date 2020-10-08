# require_relative 'user'
# require_relative 'channel'



require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'recipient'
Dotenv.load

class Workspace < Recipient
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
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
    return @selected.to_details# = Recipient.path_to_details
  end

  def no_selection?
    @selected.nil?
  end

  def send_message(user_response)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.get(url, query:
        {
            token: ENV["SLACK_TOKEN"],
            channel: @selected.slack_id,
            text: user_response
        }
    )
  end

end