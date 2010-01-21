class QuestionsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin, :except => [:show, :answer, :current]
  before_filter :fetch_game
  before_filter :tag_cloud
  
  def index
    if @game
      unless @game.started?
        @game.started = true
      end
      @game_question = @game.next_question!
      @game.save
    else
      @questions = Question.paginate :page => params[:page]
    end
  end
  
  def tag
    @tag = params[:id]
    @questions = Question.tagged_with(params[:id], :on => :tags)
    render :template => 'questions/index'
  end
  
  def show
    @team = current_user.captained_team
    @game_question = @game.currently_asked_question
    @answer = Answer.new
    @answer.team = @team
    @answer.asked_question = @game_question
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Question created"
      redirect_to questions_url
    else
      render :action => :new
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Question updated"
      redirect_to questions_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_url
  end
  
  def current
    @game_question = @game.currently_asked_question
    if current_user.admin? && @game_question.nil?
      @game_question = @game.next_question!
    end
    
    unless current_user.admin?
      @team = current_user.captained_team
      @answer = Answer.find(:all, :conditions => {:team_id => @team.id, :games_question_id => @game_question.id}).first
      if @answer.nil?
        @answer = Answer.new
        @answer.team = @team
        @answer.asked_question = @game_question
      end
    end

    render :template => 'questions/show'
  end
  
  def next
    @game_question = @game.next_question!
    render :template => 'questions/show'
  end
  
  def lock
    @game_question = @game.currently_asked_question
    @game_question.locked = true
    @game_question.save
    render :template => 'questions/show'
  end
  
  def answer
    @team = current_user.captained_team
    @game_question = @game.currently_asked_question
    @answer = Answer.find(:all, :conditions => {:team_id => @team.id, :games_question_id => @game_question.id}).first
    if @game_question.locked?
      flash[:notice] = "This question has already been locked. Answers are no longer being accepted."
    elsif !@answer.nil?
      flash[:notice] = "Your answer has already been submitted."
    else
      @answer = Answer.new(params[:answer])
      @answer.team = @team
      @answer.asked_question = @game_question
      if @answer.save
        flash[:notice] = "Your answer has been submitted."
      end
    end
    
    render :action => 'show'
  end

private
  def fetch_game
    @game = Game.find(params[:game_id]) if params[:game_id]
  end
  
  def tag_cloud
    @tags = Question.tag_counts_on(:tags)
  end
end