class AddAssetsToProjects < ActiveRecord::Migration

  def self.up
    create_table :assets_projects, :id => false do |t|
      t.integer :asset_id
      t.integer :project_id
    end
    add_index :assets_projects, :asset_id
    add_index :assets_projects, :project_id
  end

  def self.down
    drop_table :assets_projects
  end

end