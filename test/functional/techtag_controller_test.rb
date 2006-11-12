require File.dirname(__FILE__) + '/../test_helper'
require 'techtag_controller'

# Re-raise errors caught by the controller.
class TechtagController; def rescue_action(e) raise e end; end

class TechtagControllerTest < Test::Unit::TestCase
  def setup
    @controller = TechtagController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
