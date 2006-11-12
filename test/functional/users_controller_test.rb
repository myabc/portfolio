require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < Test::Unit::TestCase
  fixtures :users

  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_destroy_using_get
    assert_not_nil User.find(1)

    get 'destroy', :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'edit'

    assert_not_nil User.find(1)
  end

  def test_destroy_using_post
    assert_not_nil User.find(1)

    post 'destroy', :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) { User.find(1) }
  end

  def test_destroy_without_id
    assert_not_nil User.find(1)

    post 'destroy'
    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert flash.has_key?(:notice)

    assert_not_nil User.find(1)
  end

  def test_edit_using_get
    get 'edit', :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:user)
    assert assigns(:user).valid?
  end

  def test_edit_using_post
    post 'edit', :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_edit_without_id
    post 'edit'
    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert flash.has_key?(:notice)
  end

  def test_list
    get 'list'

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:users)
  end

  def test_new_using_get
    get 'new'

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:user)
  end

  def test_new_using_post
    num_users = User.count

    post 'new', :user => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_users + 1, User.count
  end

  def test_show
    get 'show', :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:user)
    assert assigns(:user).valid?
  end

  def test_show_without_id
    get 'show'

    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert flash.has_key?(:notice)
  end
end
