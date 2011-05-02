class GiftMailer < ActionMailer::Base
  default :from => "partyplanner91@gmail.com"
  
  def new_gift (gift)
	@gift = gift
	mail(:to => gift.invitation.guest.email, :subject => "Thanks for the gift")
  end
  
end
