class PartyType < ActiveRecord::Base
  attr_accessible :name, :active
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :parties
  
  
  # Validations
  # -----------------------------
  validates_presence_of :name
end
