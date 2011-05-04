require 'test_helper'

class GiftTest < ActiveSupport::TestCase

	should belong_to(:invitation)

	should validate_presence_of(:invitation_id)
	should validate_presence_of (:note_sent_on)
	
end
