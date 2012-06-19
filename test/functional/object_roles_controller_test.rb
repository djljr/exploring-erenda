require File.dirname(__FILE__) + '/../test_helper'
require 'object_roles_controller'

# Re-raise errors caught by the controller.
class ObjectRolesController; def rescue_action(e) raise e end; end

class ObjectRolesControllerTest < Test::Unit::TestCase
  def setup
    @controller = ObjectRolesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
