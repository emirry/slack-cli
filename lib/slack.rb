#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require_relative 'workspace'
Dotenv.load
#
URL = "https://slack.com/api/"

def main
  # Dotenv.load
  unless ENV["SLACK_TOKEN"]
    puts "Could not load API key"
    exit
  end

  # while true
  puts "Welcome to the Ada Slack CLI! 'quit' to exit"
  puts "Choose: list users | list channels | quit"
  # user_input = gets.chomp

  # break if user_input.downcase == 'quit'

  workspace = Workspace.new
  # user should see how many channels and users there are
  #   list users: see list of users (username, real name, slack id)
  #   list channels: list of channels (channel's name, topic, member count, slack id)
  #   quit

  response = HTTParty.get(URL, query: {
  q: "users.list",
  token: ENV['SLACK_TOKEN'],
  format: 'json'
  }
  )
  # end

  # unless response == 200
  #   raise error
  # end
  ap response['members']
  return JSON.parse(response.body).class
  # if user_input == 'list users'
  #   # ap response['members'].first['id']
  # # elsif user_input == 'list channels'
  # #   return response['']
  # else
  #   user_input == 'exit'
  #   return "BYE!"
  # end


  puts "Thank you for using the Ada Slack CLI"
end


main if __FILE__ == $PROGRAM_NAME