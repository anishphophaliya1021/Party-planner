class Gift < ActiveRecord::Base
  attr_accessible :invitation_id, :note_sent_on, :description
  
  #RELATIONSHIPS
  #---------------------------------------------
  belongs_to :invitation
  belongs_to :guest
  belongs_to :host
  belongs_to :party
  
  # Validations
  # -----------------------------
  validates_presence_of :invitation_id
  validates_presence_of :note_sent_on, :allow_nil => true
  validates_inclusion_of :invitation_id, :in => Invitation.all.map{|i| i.id}
  
end
