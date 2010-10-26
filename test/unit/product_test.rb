require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  context "An intangible product" do
    subject { Product.new(:tangible => false) }

    should validate_presence_of(:title)
    should_not allow_value('22').for(:size)
    should allow_value('22kb').for(:size)
    should ensure_inclusion_of(:price).in_range(0..99)
  end

  context "A tangible product" do
    subject { Product.new(:tangible => true) }

    should validate_presence_of(:price)
    should ensure_inclusion_of(:price).in_range(1..9999)
    should ensure_inclusion_of(:weight).in_range(1..100)
    should_not allow_value('22').for(:size)
    should_not allow_value('10x15').for(:size)
    should allow_value('12x12x1').for(:size)
    should ensure_length_of(:size).is_at_least(5).is_at_most(20)
  end
end
