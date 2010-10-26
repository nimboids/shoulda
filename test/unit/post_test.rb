require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :all

  should belong_to(:user)
  should belong_to(:owner)
  should have_many(:tags).through(:taggings)
  should have_many(:through_tags).through(:taggings)

  should validate_uniqueness_of(:title)
  should validate_presence_of(:body).with_message(/wtf/)
  should validate_presence_of(:title)
  should validate_numericality_of(:user_id)
end
