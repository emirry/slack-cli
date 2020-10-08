#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'workspace'
Dotenv.load

# URL_USERS = "https://slack.com/api/users.list"
# URL_CHANNELS = "https://slack.com/api/conversations.list"



def main
  # Class InvalidError < StandardError; end

# if we want to create a custom error
#   unless response == 200
#     raise InvalidError,"Invalid #{response.code}"
#   end
#
#   unless response_users  == 200
#     raise ArgumentError.new("Something went wrong!")
#   end
#
#   unless response_channels  == 200
#     raise ArgumentError.new("Something went wrong!")
#   end

  unless ENV["SLACK_TOKEN"]
    puts "Could not load API key"
    exit
  end

  puts "Welcome to the Ada Slack CLI! 'quit' to quit"

  while true
    puts "Choose: list users | list channels | select user | select channel | show details | quit"

    user_input = gets.chomp

    break if user_input.downcase == 'quit'

    if user_input == 'list users'
      tp User.list_all, 'slack_id', 'name', 'real_name'
    elsif user_input == 'list channels'
      tp Channel.list_all, 'slack_id','name', 'topic', 'member_count'
    elsif user_input == 'select user'
      print 'Which user would you like to select?'
      user_to_select = gets.chomp
      puts Workspace.select_user(user_to_select)
    elsif user_input == 'select channel'
      print 'Which channel would you like to select?'
      channel_to_select = gets.chomp
      puts Workspace.select_channel(channel_to_select)
    elsif user_input == 'show details'
      puts Workspace.show_details
    else
      puts "Invalid entry!"
    end

  end

  workspace = Workspace.new

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME