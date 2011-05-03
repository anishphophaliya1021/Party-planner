class PasswordMailer < ActionMailer::Base
  default :from => "partyplanner91@gmail.com"
  
  def send_password(pass, h)
	@password = pass
	@host = h
	mail(:to => h.email, :subject => "Password Reset for Party Planner")
  end
end
