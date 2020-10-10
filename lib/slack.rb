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

    exit if user_input.downcase == 'quit'

    case user_input
    when 'list users'
      tp User.list_all, 'name', 'slack_id', 'real_name'
    when'list channels'
      tp Channel.list_all, 'name', 'slack_id', 'topic', 'member_count'
    when 'select user'
      print 'Which user would you like to select? '
      user_to_select = gets.chomp
      if workspace.user_doesnt_exist?(user_to_select)
        puts "Invalid user name. What would you like to do?"
        driver(workspace)
      elsif workspace.select_user(user_to_select)
        print "Successfully selected #{workspace.return_selected.name}!"
      end
    when 'select channel'
      print 'Which channel would you like to select? '
      channel_to_select = gets.chomp
      if workspace.channel_doesnt_exist?(channel_to_select)
        puts "Invalid channel name. What would you like to do?"
        driver(workspace)
      elsif workspace.select_channel(channel_to_select)
        print "Successfully selected #{workspace.return_selected.name}!"
      end
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
        selected_slack_id = workspace.return_selected.slack_id
        workspace.send_message(selected_slack_id, user_response)
      end
    else
      puts "Invalid entry!"
    end
  end
end

def main

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