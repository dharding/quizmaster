module FormViewHelper
  
  def file_uploader(form, field, html_opts)
    id = "#{form.object.class.name.downcase}_#{field.to_s}"
    content_tag :div, :class => "file_uploader" do
      stuff = file_field_tag "#{form.object.class.name.downcase}[#{field.to_s}]", :id => id, :html => html_opts
      stuff += content_tag :div, :class => "fake_file_uploader" do
        existing_file_name = form.object.send(:"#{field.to_s}_file_name")
        foo = content_tag :div, existing_file_name.blank? ? "<em>Choose a file</em>" : existing_file_name, :class => "filename"
        foo += content_tag :div, :class => "button" do
          content_tag :button, "Choose"
        end
      end
    end
  end
  
  # Returns HTML for a matrix of check boxes
  def matrix(form, field, opts = {})
    required = opts[:required] || false
    container_style = opts[:container_style] || "form_item"
    col_styles = opts[:col_styles] || ["field"]
    required_style = opts[:required_style] || "required"
    include_freeform = opts[:include_freeform] || false
    freeform_label = opts[:freeform_label] || "Other"
    columns = opts[:columns] || [:field]
    check_method = opts[:check_method] || "has_#{field.to_s}?"
    html_opts = opts[:html_opts] || {}
    options = opts[:options] || []
    cols = opts[:cols] || 2
    rows = options.length / cols + ((options.length % cols).zero? ? 0 : 1) # add a row if we have a remainder
    
    counter = 0
    table_content = ""
    table_content += content_tag :table, :class => 'matrix' do
      row_content = ""
      rows.times do
        row_content += content_tag :tr do
          cell_content = ""
          cols.times do
            cell_content += content_tag :td do
              current_option = options[counter]
              inner_stuff = ""
              if current_option.is_a?(Array)
                current_option.last
                normalized_val = current_option.last
                item_name = "#{field}[#{normalized_val}]"
                inner_stuff += check_box_tag item_name, current_option.last, form.object.send(check_method, current_option.last)
                inner_stuff += label_tag item_name, current_option.first
              else
                normalized_val = current_option.downcase
                item_name = "#{field}[#{normalized_val}]"
                inner_stuff += check_box_tag item_name, normalized_val, form.object.send(check_method, current_option.downcase)
                inner_stuff += label_tag item_name, current_option
              end
              inner_stuff
            end
            counter += 1
          end
          cell_content
        end
      end
      if include_freeform
        row_content += content_tag :tr do
          content_tag :td, {:colspan => cols, :style => "padding-left: 5px"} do
            other_content = ""
            other_field = "other_#{field.to_s}"
            other_content += label_tag other_field, freeform_label
            other_content += text_field_tag other_field, form.object.send(other_field)
          end
        end
      end
      row_content
    end

    content_tag :div, table_content, :class => col_styles[columns.index(:field)]
  end
  
  def privacy_control_for(form, field, options = {})
    privacy_field = "privacy_#{field.to_s}"
    required = options[:required] || false
    container_style = options[:container_style] || "form_item"
    required_style = options[:required_style] || "required"

    gen_content = ""
    
    unless options[:label].blank?
      gen_content += content_tag :div, :class => "label" do
        (required ? "<em>*</em>" : "") << form.label(privacy_field, options[:label])
      end
    end
    
    gen_content += content_tag :div, :class => "field" do
      select(form.object.class.name.downcase, privacy_field, Privacy::OPTIONS)
    end
    
    content_tag :div, gen_content, :class => required ? "#{container_style} #{required_style}" : container_style
  end
  
  def form_item(form, field, opts = {})
    required = opts[:required] || false
    columns = opts[:columns] || [:label, :field, :message]
    col_styles = opts[:col_styles] || ["label", "field", "message"]
    container_style = opts[:container_style] || "form_item"
    required_style = opts[:required_style] || "required"
    label = opts[:label].nil? ? field.to_s.titleize : opts[:label]
    options = opts[:options] || nil
    html_opts = opts[:html_opts] || {}
    content = opts[:content] || {}
    field_type = opts[:type] || nil
    label_clickable = opts[:label_clickable]
    label_clickable = true if label_clickable.nil?
    
    if field_type.nil?
      if !options.nil?
        field_type = :select
      else
        attribute = form.object.column_for_attribute(field)
        if !attribute.nil? && attribute.sql_type == "text"
          field_type = :text_area
        end
      end
    end
    
    field_type ||= :text
    
    gen_content = {}
    
    if columns.include?(:field)
      field_content = case field_type
        when :text_area
          form.text_area field, html_opts
        when :password
          form.password_field field, html_opts
        when :matrix
          matrix(form, field, opts)
        when :checkbox
          form.check_box field, html_opts
        when :file
          file_uploader(form, field, html_opts)
        when :select
          select(html_opts[:name] || form.object.class.name.downcase, field, options, html_opts)
        else
          form.text_field field, html_opts
        end
      
      gen_content[:field] = content_tag :div, field_content, :class => col_styles[columns.index(:field)]
    end
    
    if columns.include?(:label)
      gen_content[:label] = content_tag :div, :class => col_styles[columns.index(:label)] do
        if label_clickable
          (required ? "<em>*</em>" : "") << form.label(field, label)
        else
          (required ? "<em>*</em>" : "") << label_tag(field, label)
        end
      end
    end
    
    if columns.include?(:message)
      gen_content[:message] = content_tag :div, :class => col_styles[columns.index(:message)] do
        error_message_on form.object, field
      end
    end
    
    content_tag :div, :class => required ? "#{container_style} #{required_style}" : container_style do
      form_item_content = ""
      columns.each do |section|
        form_item_content += gen_content[section]
      end
      form_item_content
    end
  end
  
  def rte(ids)
    content_for :head do
      if ids.is_a?(Array)
        content = ""
        ids.each_with_index do |id, i|
          content += render :partial => 'shared/tinymce', :object => id, :locals => {:skip_js_include => !i.zero?}
        end
        content
      else
        render :partial => 'shared/tinymce', :object => ids, :locals => {:skip_js_include => false}
      end
    end
  end
end