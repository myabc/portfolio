class AddRolesAndRightsTables < ActiveRecord::Migration
  def self.up
    create_table "rights" do |t|
       t.column "name", :string, :limit => 100
       t.column "controller", :string, :limit => 50, :default => ""
       t.column "action", :string, :limit => 50, :default => ""
     end

     create_table "rights_roles", :id => false do |t|
       t.column "right_id", :integer
       t.column "role_id", :integer
     end

     create_table "roles" do |t|
       t.column "name", :string, :limit => 100
     end

     create_table "roles_users", :id => false do |t|
       t.column "role_id", :integer
       t.column "user_id", :integer
     end
  end

  def self.down
    drop_table :rights;
    drop_table :rights_roles;
    drop_table :roles;
    drop_table :roles_users;
  end
end
