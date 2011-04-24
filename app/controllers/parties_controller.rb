class PartiesController < ApplicationController
  def index
    @parties = current_host.parties.paginate :page => params[:page], :per_page => 10
  end

  def show
    @party = Party.find(params[:id])
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(params[:party])
	@party.host_id = current_host.id
    if @party.save
      redirect_to @party, :notice => "Successfully created party."
    else
      render :action => 'new'
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
    if @party.update_attributes(params[:party])
      redirect_to @party, :notice  => "Successfully updated party."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    redirect_to parties_url, :notice => "Successfully destroyed party."
  end
end
