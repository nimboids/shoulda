require 'shoulda'
require 'shoulda/action_controller/matchers'

module Test # :nodoc: all
  module Unit
    class TestCase
      include Shoulda::ActionController::Matchers
      extend Shoulda::ActionController::Matchers
    end
  end
end

require 'shoulda/active_record/assertions'
require 'shoulda/action_mailer/assertions'

module ActionController #:nodoc: all
  module Integration
    class Session
      include Shoulda::Assertions
      include Shoulda::Helpers
      include Shoulda::ActiveRecord::Assertions
      include Shoulda::ActionMailer::Assertions
    end
  end
end

if defined?(ActionController::TestCase)
  class ActionController::TestCase
    def subject
      @controller
    end
  end
end
