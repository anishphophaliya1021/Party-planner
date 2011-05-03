namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # Step 0: clear any old data in the db
    [Host, Party, Guest, Location, Invitation, PartyType].each(&:delete_all)
    
    # Step 1: Add some party types to the system
    party_types = %w[Baby\ Shower Birthday General\ Party Graduation Holiday]
    party_types.sort.each do |pt_name|
      # create an PartyType object and assign the name passed into block
      a = PartyType.new
      a.name = pt_name
	  a.active = true
      # save with bang (!) so exception is thrown on failure
      a.save!
    end
    
    #Step 1.5: Add a default host to the system
	
	Host.populate 1 do |host|
		host.first_name = "Anish"
		host.last_name = "Phophaliya"
		host.email = "aphophal@andrew.cmu.edu"
		host.username = "aphophal"
		#password is 'secret'
		host.password_hash = "$2a$10$F62Nx0dpLdijYKPD/WXn9OkNsOsPXzQmCHpVV39bHawJ2IzzVGCaa"
		host.password_salt = "$2a$10$F62Nx0dpLdijYKPD/WXn9O"
		host.isAdmin = true
		host.created_at = Time.now
		host.updated_at = Time.now
	
      # Step 2B: Add some locations to hold parties at
      locations = {"Carnegie Mellon" => "5000 Forbes Avenue;15213", "Convention Center" => "1000 Fort Duquesne Blvd;15222", "Point State Park" => "101 Commonwealth Place;15222"}
      locations.each do |location|
        loc = Location.new
        loc.host_id = host.id
        loc.name = location[0]
        street, zip = location[1].split(";")
        loc.street = street
        loc.city = "Pittsburgh"
        loc.state = "PA"
        loc.zip = zip
        loc.save!
        sleep(3)  # necessary because of limits imposed by Google on free accounts
      end
    end
  end
end      
