class Location < ActiveRecord::Base
  attr_accessible :host_id, :name, :street, :city, :state, :zip, :latitude, :longitude
  
  #call back to update coordinates
  before_save :find_location_coordinates
  
  #RELATIONSHIPS
  #---------------------------------------------
  has_many :parties
  belongs_to :host
  
  #scopes
  #used in the populate file
  scope :for_host, lambda {|host_id| where("host_id = ?", host_id) }
  
  # Validations
  # -----------------------------
  validates_presence_of :host_id, :name, :city
  validates_numericality_of :zip, :only_integer => true, :message => "invalid zip"
  validates_length_of :zip, :in => 5..6, :wrong_length => "invalid zip"
  validates_numericality_of :longitude, :allow_nil => true
  validates_numericality_of :latitude, :allow_nil => true
  
  #Google maps
  #state list
  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]
   
   
   # Callback
	def create_map_link(zoom=13,width=1600,height=800)
		markers = "&markers=color:red%7Ccolor:red%7Clabel:%7C#{latitude},#{longitude}"
		map = "http://maps.google.com/maps/api/staticmap?center=#{self.latitude},#{self.longitude}&zoom=#{zoom}&size=#{width}x#{height}&maptype=roadmap#{markers}&sensor=false"
	end
  
  private
  
	def find_location_coordinates
		coord = Geokit::Geocoders::GoogleGeocoder.geocode "#{self.name}, #{self.street}, #{self.city}, #{self.state}"
		if coord.success
			self.latitude, self.longitude = coord.ll.split(',')
		else
			errors.add_to_base("error with geocoding")
		end
	end
  
end
