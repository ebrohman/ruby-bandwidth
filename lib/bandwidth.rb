require "bandwidth/types/instance"
require "bandwidth/types/account"
require "bandwidth/types/transaction"

require "bandwidth/api/account"

require "bandwidth/connection"
require "bandwidth/version"

module Bandwidth

  # Connect to Bandwidth API
  #
  # @param user_id [String] Your Bandwidth User Id
  # @param token [String] Your Bandwidth API Token
  # @param secret [String] Your Bandwidth API Secret
  #
  # @return [Connection] Bandwidth API access object
  #
  # @example Creating an API connection
  #   USER_ID = "u-ku5k3kzhbf4nligdgweuqie" # Your user id
  #   TOKEN  = "t-apseoipfjscawnjpraalksd" # Your account token
  #   SECRET = "6db9531b2794663d75454fb42476ddcb0215f28c" # Your secret
  #
  #   bandwidth = Bandwidth.new USER_ID, TOKEN, SECRET
  #
  def self.new user_id, token, secret
    Bandwidth::Connection.new user_id, token, secret
  end
end
