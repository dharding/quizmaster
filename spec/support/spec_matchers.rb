module Spec
  module Rails
    module Matchers
      def require_a_unique(attribute, scope = nil)
        return simple_matcher("model to require a unique #{attribute}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end
          
          existing_model = Factory.create(:"#{model.class.name.underscore}")
          model.send("#{scope}=", existing_model.send(scope)) unless scope.nil?
          model.send("#{attribute}=", existing_model.send(attribute))
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_acceptance_of(attribute)
        return simple_matcher("model to validate the acceptance of #{attribute}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end
        
          model.send("#{attribute}=", nil)
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_uniqueness_of(attribute, scope = nil )
        return simple_matcher("model to validate the uniqueness of #{attribute}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end

          existing_model = Factory.create(:"#{model.class.name.underscore}")
          unless scope.nil?
            if scope.is_a?(Array)
              scope.each do |a_scope|
                if a_scope.is_a?(Symbol)
                  model.send("#{a_scope}=", existing_model.send(a_scope))
                elsif a_scope.is_a?(String)
                  model.send("#{a_scope}=", existing_model.send(a_scope.to_sym))
                end
              end
            elsif scope.is_a?(Symbol)
              model.send("#{scope}=", existing_model.send(scope))
            elsif scope.is_a?(String)
              model.send("#{scope}=", existing_model.send(scope.to_sym))
            end
          end
          model.send("#{attribute}=", existing_model.send(attribute))
          !model.valid? && model.errors.invalid?(attribute)
        end
      end
      
      def belong_to_and_require(associated_model)
        return simple_matcher("validate model belongs_to and validates presence of '#{associated_model.to_s}'") do |model|
          if model.is_a?(Class)
            model = model.new
          end
          model.send("#{associated_model.to_s}=", nil)
          !model.valid? && model.errors.invalid?(associated_model)
        end
      end
      
      def validate_presence_of(attribute)
        return simple_matcher("model to validate the presence of #{attribute}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end
      
          model.send("#{attribute}=", nil)
          !model.valid? && model.errors.invalid?(attribute)
        end
      end
 
      def validate_length_of(attribute, options)
        if options.has_key? :within
          min = options[:within].first
          max = options[:within].last
        elsif options.has_key? :is
          min = options[:is]
          max = min
        elsif options.has_key? :minimum
          min = options[:minimum]
        elsif options.has_key? :maximum
          max = options[:maximum]
        end
        
        return simple_matcher("model to validate the length of #{attribute} within #{min || 0} and #{max || 'Infinity'}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end

          invalid = false
          if !min.nil? && min >= 1
            model.send("#{attribute}=", 'a' * (min - 1))
 
            invalid = !model.valid? && model.errors.invalid?(attribute)
          end
          
          if !max.nil?
            model.send("#{attribute}=", 'a' * (max + 1))
 
            invalid ||= !model.valid? && model.errors.invalid?(attribute)
          end
          invalid
        end
      end
 
      def validate_confirmation_of(attribute)
        return simple_matcher("model to validate the confirmation of #{attribute}") do |model|
          if model.is_a?(Class)
            clazz = model
            model = Factory.build(:"#{clazz.name.underscore}")
          else
            clazz = model.class
          end

          model.send("#{attribute}_confirmation=", 'asdf')
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def have_identifier_for(system, value, default_namespace_prefix='x')
        return simple_matcher("node with <#{default_namespace_prefix}:identifier> child element for system='#{system}' and value='#{value}'") do |node|
          valid = true
          valid &&= (node.find("#{default_namespace_prefix}:identifiers").length == 1)
          valid &&= (node.find("#{default_namespace_prefix}:identifiers/#{default_namespace_prefix}:identifier/#{default_namespace_prefix}:system[. = '#{system}']").length == 1)
          system = node.find_first("#{default_namespace_prefix}:identifiers/#{default_namespace_prefix}:identifier/#{default_namespace_prefix}:system[. = '#{system}']")
          valid &&= (system.parent.find("#{default_namespace_prefix}:value[. = '#{value}']").length == 1)
          valid
        end
      end
    end
  end
end