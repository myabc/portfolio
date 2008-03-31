class CreateClients < ActiveRecord::Migration
  def self.up
    create_table "clients" do |t|
      t.column "short_name", :string, :limit => 20, :default => "", :null => false
      t.column "name", :string, :default => "", :null => false
      t.column "client_uri", :string
      t.column "description", :text
    end

    add_index "clients", ["short_name"], :name => "short_name"
    add_index "clients", ["name"], :name => "name"
  end

  def self.down
    drop_table :clients
  end
end
