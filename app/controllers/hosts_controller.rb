class HostsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @host = Host.new
  end
  
  def index
		if(current_host.username == "AdMiNiStRaToR")
			@hosts=Host.all
		else
			redirect_to root_url, :notice => "Sorry you don't have permission to access this page"
		end
  end
  
  def show
	 @host = Host.find(params[:id])
  end
  
  def create
    @host = Host.new(params[:host])
    if @host.save
      session[:host_id] = @host.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @host = current_host
  end

  def update
    @host = current_host
    if @host.update_attributes(params[:host])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
		@host = Host.find(params[:id])
		@host.destroy
		redirect_to hosts_url, :notice => "Successfully destroyed host."
		#redirect_to hosts_url, :notice => "cannot destroy host #{session[:host_id]} , #{@host.id}."
  end
end
