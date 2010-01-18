class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
    if @user.nil?
      flash[:error] = "Unable to activate account."
      redirect_to root_url and return
    end
    
    if @user.active?
      flash[:notice] = "Your account is already activated. Please login using the form below."
      redirect_to root_url and return
    end
    
    if @user.activate!
      @user.deliver_activation_confirmation!
      flash[:notice] = "Your account has been activated. Please login using the form below."
      # TODO: auto login
      redirect_to login_url
    else
      flash[:error] = "Unable to activate account."
      render :action => :new
    end
  end

  def create
    @user = User.find(params[:id])

    if @user.active?
      flash[:notice] = "Your account is already activated. Please login using the form below."
      redirect_to login_url and return
    end

    if @user.activate!
      @user.deliver_activation_confirmation!
      flash[:notice] = "Your account has been activated. Please login using the form below."
      # TODO: auto login
      redirect_to login_url
    else
      render :action => :new
    end
  end
end