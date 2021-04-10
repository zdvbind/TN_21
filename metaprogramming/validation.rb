# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, validation, parametr = nil)
      @validations ||= []
      @validations << {
        attr: attr_name,
        law: validation,
        parametr: parametr
      }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations&.each do |validation|
        attr_value = instance_variable_get("@#{validation[:attr]}")
        send validation[:law], validation[:attr], attr_value, validation[:parametr]
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    private

    def presence(attr_name, attr_value, _unused)
      raise ArgumentError, "@#{attr_name} can not be nil" unless attr_value
    end

    def format(attr_name, attr_value, pattern)
      raise ArgumentError, "@#{attr_name} does not have a valid format" unless attr_value =~ pattern
    end

    def type(attr_name, attr_value, valid_class)
      raise ArgumentError, "@#{attr_name} does not have a valid class" unless attr_value.is_a?(valid_class)
    end

    def permitted_value(attr_name, attr_value, values)
      raise ArgumentError, "@#{attr_name} can be only from #{values}" unless values.include?(attr_value)
    end

    def positive_value(attr_name, attr_value, _unused)
      raise ArgumentError, "@#{attr_name} can be only positive " unless attr_value&.positive?
    end
  end
end
