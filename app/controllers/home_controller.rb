class HomeController < ApplicationController
  def index
    if logged_in?
      @team = current_user.captained_team
      @game = @team.active_game unless @team.nil?
      @game_question = @game.currently_asked_question unless @game.nil?
      
      if @game_question
        redirect_to game_question_path(@game, @game_question)
      end
    end
  end
end