require_relative 'test_helper'

describe "Workspace class" do
  describe "Workspace instantiation" do
    it "validates for 0 users" do
      VCR.use_cassette("workspace") do
      workspace = Workspace.new

      expect {
        workspace.validate_user?([])
      }.must_raise ArgumentError
      end
    end

    it "validates for 0 channels" do
      VCR.use_cassette("workspace") do
        workspace = Workspace.new

        expect {
          workspace.validate_channel?([])
        }.must_raise ArgumentError
      end
    end

    it "validates for nil users" do
      VCR.use_cassette("workspace") do
        workspace = Workspace.new

        expect {
          workspace.validate_user?(nil)
        }.must_raise ArgumentError
      end
    end

    it "validates for nil channels" do
      VCR.use_cassette("workspace") do
        workspace = Workspace.new

        expect {
          workspace.validate_channel?(nil)
        }.must_raise ArgumentError
      end
    end
  end

  describe "send_message" do
    it "can send a message" do
      VCR.use_cassette("send message") do
        workspace = Workspace.new
        channel = Channel.new("Slackbot Workspace", 12362, "Random", 5)
        message = workspace.send_message(channel, "hi")
        expect(message).must_equal true

    end
    end
    end
end