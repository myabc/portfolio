class Project < ActiveRecord::Base
  
  validates_presence_of :name
  has_many :imagesets, :order => "ord"
  belongs_to :medium
  belongs_to :client
  
  # set the default values for pagination
  cattr_reader :per_page
  @@per_page = 10
end