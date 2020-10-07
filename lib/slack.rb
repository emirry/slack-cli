#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'

require_relative 'workspace'
Dotenv.load

URL_USERS = "https://slack.com/api/users.list"
URL_CHANNELS = "https://slack.com/api/conversations.list"

def main
  Class InvalidError < StandardError; end

# if we want to create a custom error
  unless response == 200
    raise InvalidError,"Invalid #{response.code}"
  end

  unless response_users  == 200
    raise ArgumentError.new("Something went wrong!")
  end

  unless response_channels  == 200
    raise ArgumentError.new("Something went wrong!")
  end

  unless ENV["SLACK_TOKEN"]
    puts "Could not load API key"
    exit
  end

  puts "Welcome to the Ada Slack CLI! 'quit' to quit"

  while true

    puts "Choose: list users | list channels | quit"

    user_input = gets.chomp

    break if user_input.downcase == 'quit'

    response_users = HTTParty.get(URL_USERS, query: {
      token: ENV['SLACK_TOKEN'],
      format: 'json'
    }
    )

    response_channels = HTTParty.get(URL_CHANNELS, query: {
        token: ENV['SLACK_TOKEN'],
        format: 'json'
    }
    )

    if user_input == 'list users'
      tp response_users['members'], 'id', 'name', 'real_name'
    elsif user_input == 'list channels'
      tp response_channels['channels'], 'name', 'purpose', 'num_members', 'id'
    else
      puts "Invalid entry!"
    end

  end


  workspace = Workspace.new
  # user should see how many channels and users there are
  #   list users: see list of users (username, real name, slack id)
  #   list channels: list of channels (channel's name, topic, member count, slack id)
  #   quit
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME