require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :all

  should have_many(:posts)
  should have_many(:dogs)
  should have_many(:cats)

  should have_many(:friendships)
  should have_many(:friends)

  should have_one(:address)
  should have_one(:address).dependent(:destroy)

  should have_db_index(:email)
  should have_db_index(:name)
  should have_db_index(:age)
  should have_db_index([:email, :name]).unique(true)
  should have_db_index(:age).unique(false)

  should_not allow_value('blah').for(:email)
  should_not allow_value('b lah').for(:email)
  should allow_value('a@b.com').for(:email)
  should allow_value('asdf@asdf.com').for(:email)
  should allow_value(1).for(:age)
  should allow_value(10).for(:age)
  should allow_value(99).for(:age)
  should_not allow_value('a').for(:age)
  should_not allow_value('-').for(:age)
  should_not allow_value('a').for(:ssn)
  should_not allow_value(1234567890).for(:ssn)
  should ensure_length_of(:email).is_at_least(1).is_at_most(100)
  should validate_numericality_of(:age)
  should ensure_inclusion_of(:age).in_range(1..100).with_high_message(/less/).with_low_message(/greater/)

  should_not allow_mass_assignment_of(:password)
  should have_db_column(:name)
  should have_db_column(:email)
  should have_db_column(:age)
  should have_db_column(:id).of_type(:integer)
  should have_db_column(:email).of_type(:string).with_options(:default => nil, :precision => nil, :limit => 255, :null => true, :scale => nil)
  should validate_acceptance_of(:eula)
  should validate_uniqueness_of(:email).scoped_to(:name).case_insensitive

  should ensure_length_of(:ssn).is_equal_to(9).with_message("Social Security Number is not the right length")
  should validate_numericality_of(:ssn)

  should have_readonly_attribute(:name)

  should have_one(:profile).through(:registration)
end
