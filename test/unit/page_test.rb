require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase

  def test_should_verify_presence_of_title
    page = new_page
    page.title = ""
    assert !page.valid?
  end

  def test_should_verify_presence_of_slug
    page = new_page
    page.slug = ""
    assert !page.valid?
  end

  def test_should_verify_uniqueness_of_slug
    page = new_page
    page.save
    page2 = new_page
    assert !page2.valid?
  end

protected

  def new_page(options = {})
    Page.new({:title => "Title", :slug => "title", :body => "Body"}.merge(options))
  end

end