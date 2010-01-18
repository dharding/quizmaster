class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :members, :class_name => "User", :foreign_key => "team_id"
  belongs_to :captain, :class_name => "User", :foreign_key => "captain_id"
  
  has_many :games_teams
  has_many :games, :through => :games_teams
  has_many :answers
  
  # has_many :teams_questions
  # has_many :answers, :through => :teams_questions, :source => :answer
  
  def member_names
    self.members.collect {|m| m.name}.join(', ')
  end
  
  def captain_name
    self.captain.nil? ? 'No Captain Yet' : self.captain.name
  end
  
  def all_members
    if self.captain.nil?
      self.members
    else
      ms = Array.new(self.members)
      ms << self.captain
    end
  end
  
  def all_member_ids
    self.all_members.collect {|m| m.id}
  end
  
  def all_member_names
    self.all_members.collect {|m| m.name}.join(', ')
  end
  
  def member_attributes=(member_attributes)
    member_attributes.each do |attributes|
      members.build(attributes)
    end
  end
  
  def new_members=(m)
    m.reject {|i| i.blank?}.each do |member_id|
      self.members << User.find(member_id)
    end
  end
  
  def existing_members=(m)
    members.reject(&:new_record?).each do |member|
      members.delete(member) unless m.include?(member.id.to_s)
    end
  end
  
  def active_game
    games.select {|g| g.started? && !g.complete?}.first
  end
end