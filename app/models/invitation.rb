class Invitation < ActiveRecord::Base
  attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees
  before_create :gen_rand
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :gifts, :dependent => :destroy
  belongs_to :guest 
  belongs_to :party
  
  # Validations
  # -----------------------------
  validates_presence_of :party_id, :guest_id, :expected_attendees
  validates_numericality_of :expected_attendees, :greater_than_or_equal_to => 0, :only_integer => true
  validates_numericality_of :actual_attendees, :allow_nil => true, :greater_than_or_equal_to => 0, :only_integer => true
  
  def name
	self.guest.name.to_s + " for " + self.party.name.to_s
  end
  def gen_rand
   self.invite_code = rand(36**16).to_s(36)
  end
end
