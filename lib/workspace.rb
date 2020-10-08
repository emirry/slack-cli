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
    @selected = "none selected"
  end

  def select_user(user_to_select)
    @selected = @users.find { |user| user.name == user_to_select }
    return @selected
  end

  def select_channel(channel_to_select)
    @selected = @channels.find { |channel| channel.name == channel_to_select }
    return @selected
  end

  # def show_details #(path_to_details)
  #   return @selected # = Recipient.path_to_details
  # end

    def to_details
      return @selected.to_details# = Recipient.path_to_details
    end

  # provide details about users and channels
  # lists channels
  # lists users
  # possible methods: select_channel, select_user, show_details, send_message
end