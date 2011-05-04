class Guest < ActiveRecord::Base
  attr_accessible :name, :email, :host_id, :notes
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :invitations, :dependent => :destroy
  has_many :gifts, :through => :invitations
  has_many :parties, :through => :invitations
  belongs_to :host
  
  # Validations
  # -----------------------------
  validates_presence_of :host_id, :name, :email
  validates_format_of :email, :with => /^[a-zA-Z][-a-zA-Z0-9_\.]*\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "please enter a valid email address"
  
  #used in the populate file
  scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }
  end
