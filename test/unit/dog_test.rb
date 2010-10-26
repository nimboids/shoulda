require 'test_helper'

class Pets::DogTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:address).dependent(:destroy)
  should have_many(:treats)
  should have_and_belong_to_many(:fleas)
  should validate_presence_of(:owner_id)
  should validate_presence_of(:treats)
  should validate_presence_of(:fleas)
end
