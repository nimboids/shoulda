require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  should belong_to(:post)
  should belong_to(:tag)
end
