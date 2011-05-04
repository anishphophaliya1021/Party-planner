require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
	
	should have_many(:gifts)
	should belong_to(:guest)
	should belong_to(:party)
	
	should validate_presence_of(:guest_id)
	should validate_presence_of(:party_id)
	should validate_presence_of(:expected_attendees)
	
	should allow_value(365).for(:expected_attendees)
	should allow_value(1).for(:expected_attendees)
	should allow_value(7300).for(:expected_attendees)
  
	should_not allow_value("bad").for(:expected_attendees)
	should_not allow_value(-365).for(:expected_attendees)
	should_not allow_value(3.14159).for(:expected_attendees)

	should allow_value(365).for(:actual_attendees)
	should allow_value(1).for(:actual_attendees)
	should allow_value(7300).for(:actual_attendees)
  
	should_not allow_value("bad").for(:actual_attendees)
	should_not allow_value(-365).for(:actual_attendees)
	should_not allow_value(3.14159).for(:actual_attendees)
	
	context "create some data to work with(host, party_types, location, parties, guests, invitations)" do
		setup do
			@an = Factory.create(:host)
			@home = Factory.create(:location, :host => @an)
			@b = Factory.create(:party_type, :name => "Birthday")
			@g = Factory.create(:party_type, :name => "Graduation")
			@graduation = Factory.create(:party, :host => @an, :location => @home, :party_type => @g)
			@birthday = Factory.create(:party, :host => @an, :name => "My Birthday", :location => @home, :party_type => @b)
			@artis = Factory.create(:guest, :host => @an)
			@anish = Factory.create(:guest, :host => @an, :name => "anish", :email => "anish@example.com")
			@invite1 = Factory.create(:invitation, :party => @graduation, :guest => @artis, :expected_attendees => 2)
			@invite2 = Factory.create(:invitation, :party => @birthday, :guest => @anish, :expected_attendees => 4, :invite_code => "678uikftv3")
			@invite3 = Factory.create(:invitation, :party => @birthday, :guest => @artis, :expected_attendees => 4, :invite_code => "6fsdsfddf3", :actual_attendees => 2)
		end
		
		#here are the tests
		should "show that the invitations are properly created" do
			assert_equal "678uikftv3", @invite2.invite_code
			assert_equal "tqbFjotlD", @invite1.invite_code
		end
		
		should "show that the relationships work properly" do
			assert_equal "My Birthday", @invite2.party.name
			assert_equal "Graduation Party", @invite1.party.name
		end
		
		should "test the method 'name'" do
			assert_equal "anish for Birthday" , @invite2.name
			assert_equal "Artis Family for Graduation Party" , @invite1.name
		end

		teardown do
			@invite3.destroy
			@invite2.destroy
			@invite1.destroy
			@anish.destroy
			@artis.destroy
			@birthday.destroy
			@graduation.destroy
			@g.destroy
			@b.destroy
			@home.destroy
			@an.destroy
		end
		
	end
	
end
