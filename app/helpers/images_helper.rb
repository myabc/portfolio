#---
# Excerpted from "Rails Recipes"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_rr for more book information.
#---
module ImagesHelper

  def thumbnail(image, link=true)
	  img = image_tag(image.thumbnail_url,:alt=>image.name, :title=>image.name)
		link ? link_to(img, image.url) : img
	end
	
end