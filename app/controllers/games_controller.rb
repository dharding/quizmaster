class GamesController < ApplicationController
  before_filter :require_admin
  
  def index
    @games = Game.paginate :page => params[:page]
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.new(params[:game])
    unless params[:teams].nil?
      params[:teams].keys.each do |team_id|
        @game.teams << Team.find(team_id)
      end
    end
    if @game.save
      flash[:notice] = "Game created"
      redirect_back_or_default games_url
    else
      render :action => :new
    end
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def update
    @game = Game.find(params[:id])
    if params[:teams].nil?
      @game.teams = []
    else
      @game.teams = params[:teams].keys.collect {|t| Team.find(t)}
    end
    if @game.update_attributes(params[:game])
      flash[:notice] = "Game updated"
      redirect_back_or_default games_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_back_or_default games_url
  end
  
  def start
    @game = Game.find(params[:id])
    redirect_to current_game_questions_path(@game)
  end
  
  def continue
    @game = Game.find(params[:id])
    redirect_to current_game_questions_path(@game)
  end
end