class CreateDefaultAdmin < ActiveRecord::Migration
  def self.up
	Host.create :first_name => "Anish"
				:last_name 	=> "Phophaliya"
				:username 	=> "aphophal"
				:email 		=> "aphophal@andrew.cmu.edu"
				:password_hash => "$2a$10$F62Nx0dpLdijYKPD/WXn9OkNsOsPXzQmCHpVV39bHawJ2IzzVGCaa"
				:password_salt => "$2a$10$F62Nx0dpLdijYKPD/WXn9O"
				:isAdmin	=>	true
  end

  def self.down
  end
end
