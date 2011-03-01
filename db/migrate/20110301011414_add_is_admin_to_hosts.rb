class AddIsAdminToHosts < ActiveRecord::Migration
  def self.up
    add_column :hosts, :isAdmin, :boolean, :default => false
  end

  def self.down
    remove_column :hosts, :isAdmin
  end
end
