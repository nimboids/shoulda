require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)
end
