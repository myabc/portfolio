require 'RMagick'

class Image < ActiveRecord::Base
  
  DIRECTORY = 'public/uploaded_images'
  THUMB_MAX_SIZE = [150, 150]

  belongs_to :imageset, :foreign_key => "imageset_id"
  
  after_save :process
  after_destroy :cleanup
  
  def file_data=(file_data)
    @file_data = file_data
    write_attribute 'extension', 
                    file_data.original_filename.split('.').last.downcase
    #write_attribute 'width', this.width
    #write_attribute 'height', this.height
  end
  
  def url
    path.sub(/^public/,'')
  end
  
  def thumbnail_url
    thumbnail_path.sub(/^public/,'')
  end
  
  def path
    File.join(DIRECTORY, "#{self.id}.#{extension}")
  end
  
  def thumbnail_path
    File.join(DIRECTORY, "#{self.id}-thumb.#{extension}")
  end
  
  #######
  private
  #######
  
  def process
    if @file_data
      create_directory
      cleanup
      save_fullsize
      create_thumbnail
      @file_data = nil
    end
  end
  
  def save_fullsize
    File.open(path,'wb') do |file|
      file.puts @file_data.read
    end
    
    #self.width = img.columns
    #self.height = img.rows
  end
  
  def create_thumbnail
    img = Magick::Image.read(path).first
    
    #thumbnail = img.thumbnail(*THUMB_MAX_SIZE)
    #thumbnail = img.crop_resized!(*THUMB_MAX_SIZE)
    thumbnail = img.resize_to_fit!(*THUMB_MAX_SIZE)
    thumbnail.write thumbnail_path
  end
  
  def create_directory
    FileUtils.mkdir_p DIRECTORY
  end
  
  def cleanup
    Dir[File.join(DIRECTORY, "#{self.id}-*")].each do |filename|
      File.unlink(filename) rescue nil
    end
  end
  
end