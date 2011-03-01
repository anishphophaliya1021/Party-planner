class SessionsController < ApplicationController
  def new
  end

  def create
    host = Host.authenticate(params[:login], params[:password])
    if host
      session[:host_id] = host.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:host_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
