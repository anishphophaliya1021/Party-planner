class Party < ActiveRecord::Base
  attr_accessible :party_type_id, :host_id, :name, :location_id, :date, :start_time, :end_time, :description, :rsvp_date
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :invitations
  has_many guests, through :invitations  
  belongs_to :host
  belongs_to :location
  belongs_to :party_type
  
  
  # Validations
  # -----------------------------
  validates_presence_of :party_type_id, :host_id, :name, :location_id, :date, :start_time
  
end
