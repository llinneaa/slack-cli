require_relative 'test_helper'
require 'pry'

describe "User class" do
  before do
    BASE_URL = "https://slack.com/api/users.list"
    TOKEN = ENV["SLACK_TOKEN"]
    @query = {
      token: TOKEN
    }
  end

  it "can create an instance" do
    VCR.use_cassette("user_list_generation") do
      
      @response = HTTParty.get(BASE_URL, query: @query)

      id = "USLACKBOT"
      name = "slackbot"
      real_name = "Slackbot"
      user = User.new(id, name, real_name)
      
      expect(user).must_be_instance_of User
    end
  end

  it "can return slackbot details" do
    VCR.use_cassette("user_list_generation") do
      
      @response = HTTParty.get(BASE_URL, query: @query)

    expect(@response["members"][0]["id"]).must_equal "USLACKBOT"
    expect(@response["members"][0]["real_name"]).must_equal "Slackbot"

    end
  end

end