class Party < ActiveRecord::Base
  attr_accessible :party_type_id, :host_id, :name, :location_id, :date, :start_time, :end_time, :description, :rsvp_date
  
  before_save :rsvp_update
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :gifts, :through => :invitations
  has_many :guests, :through => :invitations
  has_many :invitations, :dependent => :destroy
  belongs_to :host
  belongs_to :location
  belongs_to :party_type
  
  # Scopes
  # -----------------------------
  scope :mostRecent, order("date","start_time")
  
  # Validations
  # -----------------------------
  validates_inclusion_of :party_type_id, :in => PartyType.all.map{|p| p.id if(p.active = true)}
  validates_presence_of :name
  validates_inclusion_of :location_id, :in => Location.all.map{|l| l.id}
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :party_type_id,:host_id,:location_id
  validates_time :end_time, :after => :start_time, :message => "end time must be after start time"
  validates_date :rsvp_date, :on_or_before => :date, :allow_nil => true, :message => "rsvp date must be before party date"
  validates_date:date, :on_or_after => Date.current, :message => "party date must be on or after today's date"
  
  def confirmed_attendees
	sum = 0
	self.invitations.each do |i|
		if(i.actual_attendees != nil)
			sum = sum + i.actual_attendees.to_i
		end
	end
	return sum
  end
  
  def rsvp_update
	if self.rsvp_date == nil
		self.rsvp_date = self.date
	end
  end
  
  def expected_attendees
	sum = 0
	self.invitations.each do |i|
		if(i.expected_attendees != nil)
			sum = sum + i.expected_attendees.to_i
		end
	end
	return sum
  end
  
end
