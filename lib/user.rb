require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

module Slack
  class User < Recipient
    BASE_URL = "https://slack.com/api/users.list"
    TOKEN = ENV["SLACK_TOKEN"]
    
    QUERY = {
      token: TOKEN}
    
    attr_reader :id, :name, :real_name
    
    def initialize(id, name, real_name)
      super(id, name)
      @real_name = real_name
    end

    def self.list
      response = self.get(BASE_URL, query: QUERY)

      users = response["members"].map do |member|
        self.new(member["id"], member["name"], member["real_name"])
      end
      return users
    end

    def details
      super << "real_name"
    end

  end
end

