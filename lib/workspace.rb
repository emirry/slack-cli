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

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def self.select_user(user_to_select)
    selection = @users.find { |user| user.name == user_to_select }
    return selection
  end

  def self.select_channel(channel_to_select)
    selection = @channels.find { |channel| channel.name == channel_to_select }
    return selection
  end

  def self.show_details
    return "Details! Details!"
  end

  # provide details about users and channels
  # lists channels
  # lists users
  # possible methods: select_channel, select_user, show_details, send_message
end