module NavigationHelper
  ANY_REGEXP = /.*/
  
  def nav_item(name, url_hash)
    controller_to_match = url_hash[:controller] || ANY_REGEXP
    action_to_match = url_hash[:action] || ANY_REGEXP
    active = controller_to_match.match(@controller.controller_name) && action_to_match.match(@controller.action_name)
    if active
      "<li class=\"active\"><a href=\"#{url_for(url_hash)}\">#{name}</a></li>"
    else
      "<li><a href=\"#{url_for(url_hash)}\">#{name}</a></li>"
    end
  end
end