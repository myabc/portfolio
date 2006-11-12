class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.column :name, :string
    end
    
    add_column :projects, :medium_id, :integer
  end

  def self.down
    remove_column :projects, :medium_id, :integer
    drop_table :media
  end
end
