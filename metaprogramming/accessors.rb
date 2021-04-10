# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        history = []
        attr_name = "@#{name}".to_sym
        attr_name_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(attr_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(attr_name_history) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(attr_name, value)
          instance_variable_set(attr_name_history, history << value)
        end
      end
    end

    def strong_attr_accessor(name, name_class)
      attr_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(attr_name) }
      define_method("#{name}=".to_sym) do |value|
        raise ArgumentError, 'Variable has a wrong class' unless value.is_a?(name_class)

        instance_variable_set(attr_name, value)
      end
    end
  end
end
