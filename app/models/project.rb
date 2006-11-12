class Project < ActiveRecord::Base
  acts_as_taggable
  
  #keane
  validates_presence_of :name
  has_many :imagesets, :order => "ord"
  belongs_to :medium
  belongs_to :client
end