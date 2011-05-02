class InvitationMailer < ActionMailer::Base
  default :from => "partyplanner91@gmail.com"
  
  def new_invitation (invitation)
	@invitation = invitation
	mail(:to => invitation.guest.email,	:subject =>	"Invitaion for #{invitation.party.name}")
  end
  
  def cancel_invitation (invitation)
	@invitation = invitation
	mail(:to => invitation.guest.email,	:subject =>	"Invitaion cancelled for #{invitation.party.name}")
  end
end
