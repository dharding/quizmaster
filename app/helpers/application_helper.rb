# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def p(obj, field)
    if obj.class == User && field.to_s == 'name'
      private_user_name(obj)
    end
    
    if Privacy.visible?(obj, field)
      obj.send(field)
    else
      "Hidden"
    end
  end
  
  def fl
    render :partial => 'shared/flash', :object => flash if flash.present?
  end
  
private
  def private_user_name(obj)
    name_parts = []
    name_parts << p(obj, :first_name)
    name_parts << p(obj, :last_name)
    name_parts.join(' ')
  end
end
