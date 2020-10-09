require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'workspace'
Dotenv.load

def driver(workspace)

  while true
    puts "\nChoose: list users | list channels | select user | select channel | show details | send message | quit"

    user_input = gets.chomp

    break if user_input.downcase == 'quit'

    case user_input
    when 'list users'
      tp User.list_all, 'name', 'slack_id', 'real_name'
    when'list channels'
      tp Channel.list_all, 'name', 'slack_id', 'topic', 'member_count'
    when 'select user'
      print 'Which user would you like to select? '
      user_to_select = gets.chomp
      print "You selected #{user_to_select}!" # validate user input here
      workspace.select_user(user_to_select)
    when 'select channel'
      print 'Which channel would you like to select? '
      channel_to_select = gets.chomp
      print "You selected #{channel_to_select}!" # validate user input here
      workspace.select_channel(channel_to_select)
    when 'show details'
      if workspace.no_selection? # would like to refactor this for DRY
        puts "Nothing was selected!"
        driver(workspace)
      else
        print workspace.to_details
      end
    when 'send message'
      if workspace.no_selection?
        puts "Nothing was selected!"
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

  unless ENV["SLACK_TOKEN"]
    puts "Could not load API key"
    exit
  end

  workspace = Workspace.new
  puts "Welcome to the Ada Slack CLI! 'quit' to quit"
  puts "There are #{User.list_all.length} users."
  puts "There are #{Channel.list_all.length} channels."

  driver(workspace)


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME