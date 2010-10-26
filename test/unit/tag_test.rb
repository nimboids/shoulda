require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should have_many(:taggings).dependent(:destroy)
  should have_many(:posts)

  should ensure_length_of(:name).is_at_least(2)

  should_not allow_mass_assignment_of(:secret)
  should allow_mass_assignment_of(:name)
end
