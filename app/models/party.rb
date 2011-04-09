class Party < ActiveRecord::Base
  attr_accessible :party_type_id, :host_id, :name, :location_id, :date, :start_time, :end_time, :description, :rsvp_date
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :invitations, :dependent => :destroy
  has_many :gifts, :through => :invitations
  has_many :guests, :through => :invitations
  belongs_to :host
  belongs_to :location
  belongs_to :party_type
  
  # Scopes
  # -----------------------------
  #very important scope...helps in accessing info of the current user!!!
  scope :currentUser, lambda{|h| where(["host_id = ?" ,h.id ])}
  scope :mostRecent, order("date","start_time")
  
  # Validations
  # -----------------------------
  validates_inclusion_of :party_type_id, :in => PartyType.all.map{|p| p.id if(p.active = true)}
  validates_presence_of :name
  validates_inclusion_of :location_id, :in => Location.all.map{|l| l.id}
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :party_type_id,:host_id,:location_id
  
end
