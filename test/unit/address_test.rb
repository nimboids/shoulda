require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  fixtures :all

  should belong_to(:addressable)
  should validate_uniqueness_of(:title).scoped_to([:addressable_id, :addressable_type])
  should ensure_length_of(:zip).is_at_least(5)
  should validate_numericality_of(:zip)
end
