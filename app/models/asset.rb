class Asset < ActiveRecord::Base

  has_attachment :storage => :file_system, 
                 :max_size => 500.kilobytes # ,
                 # :content_type => :image, 
                 # :resize_to => '320x200>',
                 # :thumbnails => { :thumb => '100x100>' }

  validates_as_attachment

  has_and_belongs_to_many :projects

  def name
    filename
  end

end