class AddTagSupport < ActiveRecord::Migration
  def self.up
    
    create_table :tags do |t|
      t.column :name, :string
    end
        
    create_table :taggings do |t|
      t.column :tag_id, :integer
      t.column :taggable_id, :integer
      t.column :taggable_type, :string
    end

    add_index :tags, :name
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
