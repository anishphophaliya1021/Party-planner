class HostsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
		@host = Host.new
  end
  
  def index
		if(current_host.isAdmin == true)
			@hosts=Host.all.paginate :page => params[:page], :per_page => 10
		else
			redirect_to root_url, :notice => "Sorry you don't have permission to access this page"
		end
  end
  
  def show
	 @host = Host.find(params[:id])
  end
  
  def create
	if(!logged_in? || current_host.isAdmin == true)
		@host = Host.new(params[:host])
		if (@host.save)
			session[:host_id] = @host.id
			redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
		else
			render :action => 'new'
		end
	else
		redirect_to root_url, :notice => "Sorry you don't have permission to create a new user"
	end
  end

  def edit
    if(current_host.isAdmin == false)
		@host = current_host
	else
		@host = Host.find(params[:id])
	end
  end

  def update
    if(current_host.isAdmin == false)
		@host = current_host
	else
		@host = Host.find(params[:id])
	end
    if @host.update_attributes(params[:host])
      render :action => 'show', :notice => "The profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
	if(current_host.isAdmin == true)
		@host = Host.find(params[:id])
		@host.destroy
		redirect_to hosts_url, :notice => "Successfully destroyed host."
	else
		redirect_to hosts_url, :notice => "cannot destroy host #{session[:host_id]} , #{@host.id}."
	end
  end
end
