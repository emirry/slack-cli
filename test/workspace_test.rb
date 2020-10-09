require_relative 'test_helper'

describe "Workspace class" do
  describe "Workspace instantiation" do
    it "validates for empty user array" do
      VCR.use_cassette("empty user array") do
      workspace = Workspace.new
      expect {
        workspace.validate_user?([])
      }.must_raise ArgumentError
      end
    end

    it "validates for empty channel array" do
      VCR.use_cassette("empty channel array") do
        workspace = Workspace.new
        expect {
          workspace.validate_channel?([])
        }.must_raise ArgumentError
      end
    end

    it "validates for nil users" do
      VCR.use_cassette("nil users") do
        workspace = Workspace.new
        expect {
          workspace.validate_user?(nil)
        }.must_raise ArgumentError
      end
    end

    it "validates for nil channels" do
      VCR.use_cassette("nil channels") do
        workspace = Workspace.new
        expect {
          workspace.validate_channel?(nil)
        }.must_raise ArgumentError
      end
    end

    it "validates for existing user" do
      VCR.use_cassette("validates existing user") do
        workspace = Workspace.new
        not_existing_user_name = workspace.user_doesnt_exist?("not existing")
        existing_user_name = workspace.user_doesnt_exist?("slackbot")
        not_existing_user_id = workspace.user_doesnt_exist?("bad id")
        existing_user_id = workspace.user_doesnt_exist?("USLACKBOT")
        expect(not_existing_user_name).must_equal true
        expect(existing_user_name).must_be_nil
        expect(not_existing_user_id).must_equal true
        expect(existing_user_id).must_be_nil
      end
    end

    it "validates for existing channel" do
      VCR.use_cassette("validates existing channel") do
        workspace = Workspace.new
        not_existing_channel_name = workspace.channel_doesnt_exist?("not existing")
        existing_channel_name = workspace.channel_doesnt_exist?("slack-cli")
        not_existing_channel_id = workspace.channel_doesnt_exist?("bad id")
        existing_channel_id = workspace.channel_doesnt_exist?("C01BXHENHDK")
        expect(not_existing_channel_name).must_equal true
        expect(existing_channel_name).must_be_nil
        expect(not_existing_channel_id).must_equal true
        expect(existing_channel_id).must_be_nil
      end
    end
  end

  describe "send_message" do
    it "can send a message" do
      VCR.use_cassette("send message") do
        workspace = Workspace.new
        valid_id = "C01BXHENHDK"
        message = workspace.send_message(valid_id, "HI!")
        expect(message).must_equal true
      end
    end
  end
end