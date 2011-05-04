require 'test_helper'

class PartyTypeTest < ActiveSupport::TestCase
 
should validate_presence_of(:name)

should have_many(:parties) 

end