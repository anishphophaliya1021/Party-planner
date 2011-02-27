class Guest < ActiveRecord::Base
  attr_accessible :name, :email, :host_id, :notes
end
