require File.dirname(__FILE__) + '/../test_helper'

class PageControllerTest < ActionController::TestCase

  fixtures :pages

  def test_should_show_published_page
    page = pages(:about)
    get :show, { :anything => [page.slug] }
    assert_response :success
    assert_template 'show'
  end

  def test_should_not_show_unpublished_page
    page = pages(:unpublished)
    assert_raise(ActiveRecord::RecordNotFound){
      get :show, { :anything => [page.slug] }
    }
  end

end