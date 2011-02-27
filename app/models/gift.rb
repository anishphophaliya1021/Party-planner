class Gift < ActiveRecord::Base
  attr_accessible :invitation_id, :note_sent_on, :description
end
