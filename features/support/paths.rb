module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /logout/
      logout_path
    when /login page$/
      login_path
    when /the user admin(istration)? page/
      users_path
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      page_name =~ /^(the)?\s+(.*)\s+page$/
      page_parts = $2.split(/\s+/)
      if page_parts.length == 1
        eval("#{page_parts.first}_path")
      else
        page = page_parts.select {|p| p.downcase.singularize}.join('_')
        eval("#{page}_path")
      end
      # raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      #   "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
