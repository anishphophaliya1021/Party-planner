class GiftsController < ApplicationController
	before_filter :login_required
  def index
	@gifts = Gift.all
	@gifts.select! {|g| current_host.invitations.each{|i| i.id = g.invitation_id}}
  end

  def show
    @gift = Gift.find(params[:id])
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.new(params[:gift])
	@gift.note_sent_on = Date.today
    if @gift.save
	  GiftMailer.new_gift(@gift).deliver
      redirect_to @gift, :notice => "Successfully created gift."
    else
      render :action => 'new'
    end
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(params[:gift])
      redirect_to @gift, :notice  => "Successfully updated gift."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to gifts_url, :notice => "Successfully destroyed gift."
  end
end
