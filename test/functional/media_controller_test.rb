require File.dirname(__FILE__) + '/../test_helper'

class MediaControllerTest < ActionController::TestCase
  tests MediaController

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:media)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_medium
    assert_difference('Medium.count') do
      post :create, :medium => { }
    end

    assert_redirected_to medium_path(assigns(:medium))
  end

  def test_should_show_medium
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_medium
    put :update, :id => 1, :medium => { }
    assert_redirected_to medium_path(assigns(:medium))
  end

  def test_should_destroy_medium
    assert_difference('Medium.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to media_path
  end
end
