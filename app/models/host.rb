class Host < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :username, :password
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :guests
  has_many :locations
  has_many :parties
  
  # Validations
  # -----------------------------
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username, :email
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[a-zA-Z][-a-zA-Z0-9_\.]*\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "please enter a valid email address"
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4
  
end
