require_relative 'test_helper'

describe "User class" do
  describe "User instantiation" do
    before do
      @user = User.new("Slackbot", 27253, "Slackbot Lovelace")
    end

    it "is an instance of User class" do
      expect(@user).must_be_instance_of User
    end

    it "has attributes: name, slack_id, and real_name" do
      expect(@user.name).must_equal "Slackbot"
      expect(@user.slack_id).must_equal 27253
      expect(@user.real_name).must_equal "Slackbot Lovelace"
    end
  end

  describe 'User.list_all' do
    it "prints out an array of users" do
      VCR.use_cassette("list_all") do
      @users = User.list_all

      expect(@users).must_be_kind_of Array
      end
    end

    it "has the correct number of users" do
      VCR.use_cassette("list_all") do
        array = User.list_all.length

        expect(array).must_equal 5
      end
    end
  end


end