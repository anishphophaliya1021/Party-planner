require 'test_helper'

class GuestTest < ActiveSupport::TestCase
	should have_many(:invitations)
	should have_many(:parties).through(:invitations)
	should have_many(:gifts).through(:invitations)
	should belong_to(:host)
	
	should validate_presence_of(:host_id)
	should validate_presence_of(:name)
	should validate_presence_of(:email)
	

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
		should "show that the guests are properly created" do
			assert_equal "Artis Family", @artis.name
			assert_equal "anish", @anish.name
		end
		
		should "show that the relationships work properly" do
			assert_equal 1, @anish.invitations.size
			assert_equal 2, @artis.invitations.size
			assert_equal "An", @artis.host.first_name
			assert_equal "Heimann", @anish.host.last_name
			
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
