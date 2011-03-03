class Invitation < ActiveRecord::Base
  attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees
  before_save :gen_rand
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :gifts, :dependent => :destroy
  belongs_to :guest 
  belongs_to :party
  
  # Validations
  # -----------------------------
  validates_presence_of :party_id, :guest_id
  validates_inclusion_of :party_id, :in => Party.all.map{|p| p.id}
  validates_inclusion_of :guest_id, :in => Guest.all.map{|g| g.id}
  
  def gen_rand
   self.invite_code = rand(36**16).to_s(36)
  end
end
