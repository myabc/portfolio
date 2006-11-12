class Imageset < ActiveRecord::Base   
  has_many :images
  belongs_to :project
  acts_as_list :order => :ord
  validates_presence_of :title
  validates_numericality_of :ord, :only_integer => true, :allow_nil => false
  
  protected
    def validate
      if position < 1
        errors.add(:position , " must be greater than 0")
      end
    end
  
end