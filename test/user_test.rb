require_relative 'test_helper'

describe "User class" do
  describe "User instantiation" do
    before do
      @user = User.new("Ada", 27253, "Ada Lovelace")
    end
    it "is an instance of User class" do
      # VCR.use_cassette("initialize") do
      # @user = User.new("Ada", "8573985", "Ada Lovelace")

      #assert
      expect(@user).must_be_instance_of User
      # end
    end

    it "has attributes: name, slack_id, and real_name" do
      expect(@user.name).must_equal "Ada"
      expect(@user.slack_id).must_equal 27253
      expect(@user.real_name).must_equal "Ada Lovelace"
    end
  end

  # describe 'User.from_response_hash' do
  #   VCR.use_cassette("from_response_hash") do
  #     @users = User.from_response_hash
  #
  #     expect(@users).must_be_instance_of Array
  #   end

  describe 'User.list_all' do
    VCR.use_cassette("list_all") do
    # @users = User.list_all

    expect(User.list_all).must_be_kind_of Array
    end
  end


end