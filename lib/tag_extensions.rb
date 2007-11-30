class ActiveRecord::Base
  def tag_with tags
    tags.split(" ").each do |tag|
      Tag.find_or_create_by_name(tag).taggables << self
    end
  end

  def tag_list
    tags.map(&:name).join(' ')
  end
end