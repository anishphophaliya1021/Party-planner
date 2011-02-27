class Host < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :username, :password
end
