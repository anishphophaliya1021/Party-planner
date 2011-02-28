class Invitation < ActiveRecord::Base
  attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees
    
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :gifts
  belongs_to :guest 
  belongs_to :party
  
  # Validations
  # -----------------------------
  validates_presence_of :party_id, :guest_id
end
