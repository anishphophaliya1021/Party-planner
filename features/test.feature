Feature: Manage invitations
	As a party host
	I want to be able to manage guest invitations
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
		Given an existing birthday party
		
	When I go to the new invitation page
		And I select "Schell Family" from "invitation_guest_id"
		And I select "Birthday!" from "invitation_party_id"
		And I fill in "invitation_expected_attendees" with "5"
		And I press "Create Invitation"
		Then I should receive an email
		When I open the email with subject "Join the Party!"
		Then I should see "invite code" in the email body