class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:index, :disable, :enable, :request_reset_password]

  def index
    @users = User.paginate :page => params[:page], :order => "last_name, first_name"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    User.transaction do
      if @user.save_without_session_maintenance
        @user.deliver_activation_instructions!
        flash[:notice] = "Your account has been created. Please check your e-mail for activation instructions."
        redirect_back_or_default login_url
      else
        render :action => :new
      end
    end
  end

  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    if @current_user.id.to_s != params[:id]
      flash[:error] = "You are not authorized to perform the requested action."
      redirect_to root_url and return
    end
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end

  def disable
    if request.post?
      user = User.find(params[:id])
      user.disable!
      flash[:notice] = "User '#{user.name}' has been disabled."
      redirect_to :action => :index
    end
  end

  def enable
    if request.post?
      user = User.find(params[:id])
      user.activate!
      flash[:notice] = "User '#{user.name}' has been enabled."
      redirect_to :action => :index
    end
  end

  def request_reset_password
    if request.post?
      user = User.find(params[:id])
      user.deliver_reset_password_instructions!
      flash[:notice] = "User '#{user.name}' has been sent a reset password e-mail."
      redirect_to :action => :index
    end
  end
end