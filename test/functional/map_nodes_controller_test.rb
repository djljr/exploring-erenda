require File.dirname(__FILE__) + '/../test_helper'
require 'map_nodes_controller'

# Re-raise errors caught by the controller.
class MapNodesController; def rescue_action(e) raise e end; end

class MapNodesControllerTest < Test::Unit::TestCase
  fixtures :map_nodes

  def setup
    @controller = MapNodesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:map_nodes)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:map_node)
    assert assigns(:map_node).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:map_node)
  end

  def test_create
    num_map_nodes = MapNode.count

    post :create, :map_node => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_map_nodes + 1, MapNode.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:map_node)
    assert assigns(:map_node).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil MapNode.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MapNode.find(1)
    }
  end
end
