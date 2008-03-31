class AddStatusAndPositionToPages < ActiveRecord::Migration

  def self.up
    add_column :pages, :status, :boolean, :default => false
    add_column :pages, :position, :integer
    Page.find(:all).each_with_index do |page, index|
      page.position = index + 1
      page.save
    end
  end

  def self.down
    remove_column :pages, :status
    remove_column :pages, :position
  end

end