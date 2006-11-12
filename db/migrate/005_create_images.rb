class CreateImages < ActiveRecord::Migration
  def self.up
    create_table "images" do |t|
      t.column "name", :string, :limit => 100, :default => "", :null => false
      t.column "extension", :string, :limit => 10, :default => "", :null => false
      t.column "caption", :string
      t.column "width", :integer, :limit => 4
      t.column "height", :integer, :limit => 4
      t.column "imageset_id", :integer, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :images
  end
end
