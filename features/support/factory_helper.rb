def string_to_factory_name(str)
  unless str.is_a?(Symbol)
    str = str.gsub(/[^A-Za-z0-9]/, '_')
  end
  return str.to_sym if Factory.factories.collect {|f| f[0]}.include?(str.to_sym)
  str = str.singularize
  return str.to_sym if Factory.factories.collect {|f| f[0]}.include?(str.to_sym)
  return nil
end

def constant_for_name(name)
  klass = nil
  name = name.gsub(/[^A-Za-z0-9]/, '_')
  begin
    klass = name.camelize.constantize
  rescue
    klass = name.camelize.singularize.constantize
  end
  klass
end

def create_from_factory(factory_name, rows)
  results = []
  factory_name = string_to_factory_name(factory_name)
  rows.each do |h|
    hash = {}
    h.keys.each do |k|
      hash[k.to_s] = h[k]
    end

    # set dates dynamically
    hash.keys.select {|k| k =~ /date/}.each do |key|
      value = hash[key]
      next if value.blank?

      date_strings = []
      value.split(/,\s?/).each do |dv|
        if dv =~ /\d+\.(days?|weeks?|months?|years?)\.(ago|from_now)/
          date_strings << "#{eval($&).strftime('%Y-%m-%d')} #{$'.blank? ? Time.now.strftime('%H:%M') : $'}"
        elsif dv =~ /today/
          date_strings << Date.today.strftime('%Y-%m-%d')
        elsif dv =~ /now/
          date_strings << Time.now.strftime('%Y-%m-%d %H:%M')
        else
          date_strings << dv
        end 
      end
      hash[key] = date_strings.join(',')
    end

    hash.keys.select {|k| k =~ /_by_/}.each do |key|
      f = key.split(/_by_/)
      value = hash[key]

      if value.blank?
        hash.delete(key)
        next
      end

      unless value.blank?
        target_assoc = nil
        factories = Factory.factories.select {|j, k| j == factory_name}
        factory = factories.first
        factory_class_name = factory[1].class_name
        factory_class = factory_class_name.is_a?(Class) ? factory_class_name : factory_class_name.to_s.camelize.constantize
        factory_class.reflect_on_all_associations.select do |assoc|
          target_assoc = assoc if assoc.name.to_s == f[0]
          break unless target_assoc.nil?
        end
        unless target_assoc.nil?
          hash.delete(key)
          target_class_name = target_assoc.class_name
          begin
            hash[f[0].to_sym] = target_class_name.constantize.send("find_by_#{f[1]}", value) || Factory.create(target_assoc.class_name.tableize.singularize, {f[1].to_sym => value})
          rescue
            # We could not find a way to locate or create this, so put it back and let the factory handle it
            hash[key] = value
          end
        end
      end
    end
    results << Factory.create(factory_name, hash)
  end
  results
end