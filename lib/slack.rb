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

def driver(workspace)
  while true
    puts "\nChoose: list users | list channels | select user | select channel | show details | send message | quit"

    user_input = gets.chomp

    break if user_input.downcase == 'quit'

    if user_input == 'list users'
      tp User.list_all, 'name', 'slack_id', 'real_name'
    elsif user_input == 'list channels'
      tp Channel.list_all, 'name', 'slack_id', 'topic', 'member_count'
    elsif user_input == 'select user'
      print 'Which user would you like to select? '
      user_to_select = gets.chomp
      print "You selected #{user_to_select}"
      workspace.select_user(user_to_select)
    elsif user_input == 'select channel'
      print 'Which channel would you like to select? '
      channel_to_select = gets.chomp
      print "You selected #{channel_to_select}!" # validate user input here
      workspace.select_channel(channel_to_select)
    elsif user_input == 'show details'
      print workspace.to_details
    elsif user_input == 'send message'
      if workspace.no_selection?
        puts "Nothing was selected"
        driver(workspace)
      else
        puts "What would you like to say?"
        user_response = gets.chomp
        workspace.send_message(user_response)
      end
    else
      puts "Invalid entry!"
    end
  end
end



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

  workspace = Workspace.new

  puts "Welcome to the Ada Slack CLI! 'quit' to quit"

  driver(workspace)


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME