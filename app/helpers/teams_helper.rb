module TeamsHelper
  def add_member_link(name)
    button_to_function name, "jQuery('#members').append('#{escape_javascript render(:partial => 'member', :object => User.new)}')"
  end
  
  def fields_for_member(member, &block)
    prefix = member.new_record? ? 'new' : 'existing'
    fields_for("team[#{prefix}_members][]", member, &block)
  end
  
  def member_options_for_select(team, selected_id)
    users = User.find(:all, :order => "last_name, first_name")
    # users.reject {|u| (team.member_ids << team.captain_id).include?(u.id)}
    options = users.collect {|u| [u.name, u.id]}.unshift(['Select member', nil])
    options_for_select(options, selected_id)
  end
end