class Game < ActiveRecord::Base
  validates_presence_of :rounds
  validates_numericality_of :rounds
  validates_presence_of :questions_per_round
  validates_numericality_of :questions_per_round
  
  has_many :games_teams
  has_many :teams, :through => :games_teams
  has_many :asked_questions, :class_name => 'GamesQuestion'
  has_many :questions, :through => :asked_questions

  def winner
    teams = self.games_teams.select {|gt| gt.winner?}
    if teams.empty?
      nil
    else
      teams.first.team
    end
  end
  
  def has_team?(team)
    if team.is_a?(Team)
      team_ids.include?(team.id)
    else
      team_ids.include?(team)
    end
  end
  
  def next_question!
    if Question.count <= self.question_ids.length || (self.current_round == self.rounds && self.current_question == self.questions_per_round)
      self.complete = true
      self.save!
      return nil # no more questions!
    end
    
    question = Question.all.rand
    while self.question_ids.include?(question.id)
      question = Question.all.rand
    end
    
    game_question = GamesQuestion.new
    game_question.question = question
    game_question.game = self
    
    self.asked_questions << game_question
    
    self.current_question += 1
    
    if self.current_question > self.questions_per_round
      self.current_round += 1
      self.current_question = 1
    end
    
    if self.current_round.zero?
      self.current_round = 1
    end
    
    self.started = true
    
    self.save!
    
    game_question
  end
  
  def currently_asked_question
    self.asked_questions.last
  end
  
  def score(team = nil)
    bleh = {}
    self.team_ids.each do |team_id|
      bleh[team_id] = 0
    end
    self.asked_questions.each do |asked|
      asked.answers.each do |answer|
        if answer.correct?
          bleh[answer.team_id] += answer.points
          # asked.question.difficulty
        end
      end
    end
    grrr = bleh.select {|k, v| team.nil? || k != team.id}.collect do |team_id, points|
      [Team.find(team_id), points]
    end
    grrr.sort {|a, b| b.last <=> a.last}
  end
end