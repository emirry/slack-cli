require_relative 'test_helper'
require_relative '../lib/user'


describe "User" do

  describe "user instantiation" do
    # before do
    #   @user = User.new(name: "Ada", slack_id: 27253, real_name: "Ada Lovelace")
    # end
    it "is an instance of User class" do
      # VCR.use_cassette("initialize") do
      # arrange/act
      @user = User.new("Ada", "USLACKBOT", "Ada Lovelace")

      #assert
      expect(@user).must_be_instance_of User
      # end
    end
  end
end