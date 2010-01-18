class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.ignore_blank_passwords(false)
  end
  
  attr_protected :active
  attr_protected :admin
  attr_accessor :email_confirmation
  
  validate_on_create :validate_email_confirmation
  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 255, :allow_blank => true
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 255, :allow_blank => true
  validates_presence_of :email
  
  belongs_to :team
  has_one :captained_team, :class_name => "Team", :foreign_key => "captain_id"
  
  def name
    name_parts = []
    name_parts << self.first_name unless self.first_name.blank?
    name_parts << self.last_name unless self.last_name.blank?
    n = name_parts.join(' ')
  end

  def admin?
    self.admin
  end
  
  def active?
    self.active
  end
  
  def activate!
    self.active = true
    save!
  end
  
  def is_member_of?(team)
    team.all_member_ids.include?(self.id)
  end

  def disable!
    self.active = false
    save!
  end

  def deliver_reset_password_instructions!
    reset_perishable_token!
    AccountNotifier.deliver_reset_password_instructions(self)
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    AccountNotifier.deliver_activation_instructions(self)
  end
  
  def deliver_activation_confirmation!
    reset_perishable_token!
    AccountNotifier.deliver_activation_confirmation(self)
  end
  
private
  def validate_email_confirmation
    unless email == email_confirmation
      self.errors.add(:email, "must match")
    end
  end
end