class InvitationsController < ApplicationController
	before_filter :login_required, :except => [:start_rsvp, :rsvp_form, :update]
	
 def index
    @invitations = current_host.invitations.paginate :page => params[:page]
  end

  def start_rsvp
  end
  
  def rsvp_form
  @invitation = Invitation.all.select{|i|  i.invite_code == params[:invite_code]}
  @invitation = @invitation[0]
  end
  
  def show
    @invitation = Invitation.find(params[:id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
	  InvitationMailer.new_invitation(@invitation).deliver
      redirect_to @invitation, :notice => "#{@invitation.guest.name} has been invited via email and added to the list."
    else
      render :action => 'new'
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(params[:invitation])
		if logged_in?
			redirect_to @invitation, :notice  => "Successfully updated invitation."
		else
			redirect_to @invitation.party, :notice  => "Successfully RSVP'ed."
		end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    InvitationMailer.cancel_invitation(@invitation).deliver    
	@invitation.destroy
    redirect_to invitations_url, :notice => "#{@invitation.guest.name} has been notified about the cancellation."
  end
end
