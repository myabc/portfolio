class CreateProjects < ActiveRecord::Migration

  def self.up
    create_table :projects do |t|
      t.column "name", :string, :default => "", :null => false
      t.column "uri", :string
      t.column "start_date", :date
      t.column "end_date", :date
      t.text :description
      t.column "client_id", :integer, :limit => 4, :default => 0, :null => false
      t.column "media_type", :integer, :limit => 4, :default => 0, :null => false
      t.column "status", :integer, :limit => 4, :default => 0, :null => false
      #t.string :title
      t.boolean :status, :default => false
      t.timestamps
    end

    add_index "projects", ["name"], :name => "name"
  end

  def self.down
    drop_table :projects
  end

end