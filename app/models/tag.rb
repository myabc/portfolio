class Tag < ActiveRecord::Base
  has_many_polymorphs :taggables,
    :from => [:projects],
    :through => :taggings,
    :dependent => :destroy

end
