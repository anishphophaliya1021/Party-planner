class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
	  t.string :last_name
	  t.string :first_name
      t.string :username
      t.string :email
	  t.boolean :isAdmin, :default => false
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
