require 'test_helper'

class PartyTest < ActiveSupport::TestCase
  
  should have_many(:invitations)
  should have_many(:guests).through(:invitations)
  should have_many(:gifts).through(:invitations)
  should belong_to(:host)
  should belong_to(:party_type)
  should belong_to(:location)
  
  should validate_presence_of(:party_type_id)
  should validate_presence_of(:host_id)
  should validate_presence_of(:name)
  should validate_presence_of(:location_id)
  should validate_presence_of(:date)
  should validate_presence_of(:start_time)
  
  context "create some data to work with(host, party_types, location, parties, guests, invitations)" do
	setup do
		@an = Factory.create(:host)
		@home = Factory.create(:location, :host => @an)
		@b = Factory.create(:party_type, :name => "Birthday")
		@g = Factory.create(:party_type, :name => "Graduation")
		@graduation = Factory.create(:party, :host => @an, :location => @home, :party_type => @g)
		@grad2 = Factory.create(:party, :host => @an, :location => @home, :party_type => @g, :rsvp_date => nil)
		@birthday = Factory.create(:party, :host => @an, :name => "My Birthday", :location => @home, :party_type => @b)
		@artis = Factory.create(:guest, :host => @an)
		@anish = Factory.create(:guest, :host => @an, :name => "anish", :email => "anish@example.com")
		@invite1 = Factory.create(:invitation, :party => @graduation, :guest => @artis, :expected_attendees => 2)
		@invite2 = Factory.create(:invitation, :party => @birthday, :guest => @anish, :expected_attendees => 4, :invite_code => "678uikftv3")
		@invite3 = Factory.create(:invitation, :party => @birthday, :guest => @artis, :expected_attendees => 4, :invite_code => "6fsdsfddf3", :actual_attendees => 2)
	end
	
	#here are the tests
	should "show that the parties are properly created" do
		assert_equal "My Birthday", @birthday.name
		assert_equal "Graduation Party", @graduation.name
	end
	
	should "show that the relationships work properly" do
		assert_equal "Birthday", @birthday.party_type.name
		assert_equal "PA", @birthday.location.state
		assert_equal 2, @birthday.invitations.size
		assert_equal 1, @graduation.invitations.size
	end
	
	should "test the method to calculate expected attendees" do
		assert_equal 2 , @graduation.expected_attendees
		assert_equal 8 , @birthday.expected_attendees
	end
	should "test the method to calculate actual attendees" do
		assert_equal 5 , @graduation.actual_attendees
		assert_equal 10 , @birthday.actual_attendees	
	end
	
	should "test the callback for updating the rsvp" do
		assert_equal nil, @grad2.rsvp_date
		@grad2.rsvp_update
		assert_equal @grad2.date, @grad2.rsvp_date
	end
	
	teardown do
		@invite3.destroy
		@invite2.destroy
		@invite1.destroy
		@anish.destroy
		@artis.destroy
		@birthday.destroy
		@graduation.destroy
		@grad2.destroy
		@g.destroy
		@b.destroy
		@home.destroy
		@an.destroy
	end	
  end
  
end
