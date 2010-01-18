class AnswersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin, :only => [:correct]
  before_filter :fetch_game

  # def create
  #   @team = current_user.captained_team
  #   @game = @team.active_game
  #   @game_question = @game.currently_asked_question
  #   @answer = Answer.find(:all, :conditions => {:team_id => @team.id, :games_question_id => @game_question.id}).first
  #   if @game_question.locked?
  #     flash[:notice] = "This question is locked."
  #     render :template => 'questions/show' and return
  #   end
  #   if @answer.nil?
  #     @answer = Answer.new(params[:answer])
  #     @answer.team = @team
  #     @answer.asked_question = @game_question    
  #     if @answer.save
  #       flash[:notice] = "Your answer has been submitted."
  #       render :template => 'questions/show'
  #     else
  #       render :template => 'questions/show'
  #     end
  #   else
  #     render :template => 'questions/show'
  #   end
  # end
  
  def correct
    @answer = Answer.find(params[:id])
    @answer.correct = true
    @answer.save
    @game = Game.find(:all, :conditions => {:started => true, :complete => false}).first
    redirect_to game_question_path(@game, @answer.asked_question)
  end
  
private
  def fetch_game
    @game = Game.find(params[:game_id])
  end
end