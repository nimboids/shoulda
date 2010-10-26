require 'test_helper'

class Pets::CatTest < ActiveSupport::TestCase
  should belong_to(:owner)
  should belong_to(:address).dependent(:destroy)
  should validate_presence_of(:owner_id)
end
