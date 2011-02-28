class Location < ActiveRecord::Base
  attr_accessible :host_id, :name, :street, :city, :state, :zip, :latitude, :longitude
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :parties
  belongs_to :host
  
  # Validations
  # -----------------------------
  validates_presence_of :host_id, :name, :city
  validates_numericality_of :zip, :only_integer => true, :message => "invalid zip"
  validates_length_of :zip :in => 5..6, :wrong_length => "invalid zip"
  validates_numericality_of :longitude, :latitude	
  
end
