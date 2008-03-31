class Page < ActiveRecord::Base

  acts_as_list

  validates_presence_of :title, :slug
  validates_uniqueness_of :slug

  def self.list_published
    find(:all, :order => "position ASC", :conditions => { :status => true })
  end

end