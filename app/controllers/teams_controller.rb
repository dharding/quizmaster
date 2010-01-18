class TeamsController < ApplicationController
  before_filter :require_user, :only => [:index, :show, :update]
  before_filter :require_admin, :only => [:create, :destroy, :new]
  before_filter :must_be_member_or_admin, :only => [:edit, :update]

  def index
    @teams = Team.paginate :page => params[:page], :order => "name"
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def new
    @team = Team.new
  end
  
  def create
    params[:team][:new_members] ||= {}
    params[:team][:existing_members] ||= {}
    new_members = params[:team][:new_members]
    existing_members = params[:team][:existing_members]
    params[:team].delete(:existing_members)
    params[:team].delete(:new_members)
    @team = Team.new(params[:team])
    @team.existing_members = existing_members
    @team.new_members = new_members
    if @team.save
      flash[:notice] = "Team '#{@team.name}' has been created."
      redirect_back_or_default teams_url
    else
      render :action => :new
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def update
    @team = Team.find(params[:id])
    params[:team][:new_members] ||= {}
    params[:team][:existing_members] ||= {}
    new_members = params[:team][:new_members]
    existing_members = params[:team][:existing_members]
    params[:team].delete(:existing_members)
    params[:team].delete(:new_members)
    @team.existing_members = existing_members
    @team.new_members = new_members
    if @team.update_attributes(params[:team])
      flash[:notice] = "Team '#{@team.name}' has been updated."
      redirect_back_or_default @team
    else
      render :action => :edit
    end
  end
  
private
  def must_be_member_or_admin
    current_user.admin? || current_user.team_ids.include?(params[:id])
  end
end