require 'test_helper'

class LocationTest < ActiveSupport::TestCase

	should have_many(:parties)
	should belong_to(:host)
	
	should validate_presence_of(:host_id)
	should validate_presence_of(:name)
	should validate_presence_of(:street)
	should validate_presence_of(:city)
	should validate_presence_of(:state)
	
	should allow_value(17300).for(:zip)
	should allow_value(23745).for(:zip)
	should allow_value(100000).for(:zip)
	  
	should_not allow_value(365).for(:zip)
	should_not allow_value(1).for(:zip)
	should_not allow_value("bad").for(:zip)
	should_not allow_value(-365).for(:zip)
	
	should allow_value(-432.342).for(:longitude)
	should allow_value(0).for(:longitude)
	should allow_value(0).for(:latitude)
	
	should_not allow_value("bad").for(:longitude)
	should_not allow_value("bad").for(:latitude)
	
	context "create some data to work with(host, party_types, location, parties, guests, invitations)" do
		setup do
			@an = Factory.create(:host)
			@home = Factory.create(:location, :host => @an, :longitude => nil, :latitude => nil)
			@office = Factory.create(:location, :host => @an, :name => "My office", :city => "Pittsburgh", :state => "PA", :zip => "15213")
			@b = Factory.create(:party_type, :name => "Birthday")
			@birthday = Factory.create(:party, :host => @an, :name => "My Birthday", :location => @home, :party_type => @b)
			@artis = Factory.create(:guest, :host => @an)
			@anish = Factory.create(:guest, :host => @an, :name => "anish", :email => "anish@example.com")
			@invite1 = Factory.create(:invitation, :party => @birthday, :guest => @anish, :expected_attendees => 4, :invite_code => "678uikftv3")
			@invite2 = Factory.create(:invitation, :party => @birthday, :guest => @artis, :expected_attendees => 4, :invite_code => "6fsdsfddf3", :actual_attendees => 2)
		end
		
		#here are the tests
		should "verify that the locations have been created properly" do
			assert_equal "My office", @office.name
			assert_equal "My home", @home.name
			assert_equal "PA", @home.state
		end
		
		should "get latitude and longitude from google maps" do
			assert_nil @home.longitude
			assert_nil @home.latitude
			@home.find_location_coordinates
			assert_not_nil @home.latitude
			assert_not_nil @home.latitude
			
		end
		
		teardown do
			@invite2.destroy
			@invite1.destroy
			@anish.destroy
			@artis.destroy
			@birthday.destroy
			@b.destroy
			@home.destroy
			@office.destroy
			@an.destroy
		end
	end
	
end
