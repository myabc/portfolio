class CreateImagesets < ActiveRecord::Migration
  def self.up
    create_table "imagesets" do |t|
      t.column "title", :string, :limit => 100, :default => "", :null => false
      t.column "description", :text
      t.column "project_id", :integer, :default => 0, :null => false
      t.column "ord", :integer, :limit => 4, :default => 0, :null => false
    end

    add_index "imagesets", ["title"], :name => "title"
  end

  def self.down
    drop_table :imagesets
  end
end
