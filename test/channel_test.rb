require_relative 'test_helper'

describe "Channel class" do
  describe "Channel instantiation" do
    before do
      @channel = Channel.new("Slackbot Workspace", "12362", "Random", 5)
    end
    it "is an instance of Channel class" do
      expect(@channel).must_be_instance_of Channel
    end

    it "has attributes: name, slack_id, and real_name" do
      expect(@channel.name).must_equal "Slackbot Workspace"
      expect(@channel.slack_id).must_equal "12362"
      expect(@channel.topic).must_equal "Random"
      expect(@channel.member_count).must_equal 5
    end
  end

  describe 'Channel.list_all' do
    it "prints out an array of users" do
      VCR.use_cassette("list_all") do
        @channel = Channel.list_all
        expect(@channel).must_be_kind_of Array
      end
    end
  end

  it "has the correct number of users" do
    VCR.use_cassette("list_all") do
      array = Channel.list_all.length
      expect(array).must_equal 3
    end
  end
end