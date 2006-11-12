require File.dirname(__FILE__) + '/../test_helper'
require 'media_controller'

# Re-raise errors caught by the controller.
class MediaController; def rescue_action(e) raise e end; end

class MediaControllerTest < Test::Unit::TestCase
  fixtures :media

  def setup
    @controller = MediaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_destroy_using_get
    assert_not_nil Medium.find(1)

    get 'destroy', :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'edit'

    assert_not_nil Medium.find(1)
  end

  def test_destroy_using_post
    assert_not_nil Medium.find(1)

    post 'destroy', :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) { Medium.find(1) }
  end

  def test_destroy_without_id
    assert_not_nil Medium.find(1)

    post 'destroy'
    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert flash.has_key?(:notice)

    assert_not_nil Medium.find(1)
  end

  def test_edit_using_get
    get 'edit', :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:medium)
    assert assigns(:medium).valid?
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

    assert_not_nil assigns(:media)
  end

  def test_new_using_get
    get 'new'

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:medium)
  end

  def test_new_using_post
    num_media = Medium.count

    post 'new', :medium => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_media + 1, Medium.count
  end

  def test_show
    get 'show', :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:medium)
    assert assigns(:medium).valid?
  end

  def test_show_without_id
    get 'show'

    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert flash.has_key?(:notice)
  end
end
