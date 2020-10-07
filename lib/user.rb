require 'httparty'
require 'dotenv'
require_relative 'recipient'
require 'table_print'


Dotenv.load

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize
    @real_name
    @status_text
    @status_emoji
  end

  def self.list_all
    self.get('users.list')
    tp response['members'], 'id', 'name', 'real_name'
  end
end
