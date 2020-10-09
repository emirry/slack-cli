require_relative 'test_helper'

describe "Recipient class" do

  describe "run_get_request" do
    it "raises an error a an invalid path" do
      VCR.use_cassette("bad path") do

        expect {
          Recipient.run_get_request("bad_path")
        }.must_raise Recipient::InvalidAPIError
      end
    end #maybe ask question about this test

    it "raises an error for a false 'ok' request" do
      VCR.use_cassette("not_authed") do

        expect {
          workspace = Workspace.new
        }.must_raise Recipient::InvalidAPIError
      end
    end
  end
end