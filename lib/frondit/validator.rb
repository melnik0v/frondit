# frozen_string_literal: true

module Frondit
  module Validator # :nodoc:
    def validate!
      validate_policy
      validate_record
    end

    private

    def validate_policy
      raise Error, "Cannot find policy \"#{policy_class_path}\"" if policy_class.blank?
    end

    def validate_record
      return if record_variable_name.blank? || controller_instance.instance_variables.include?(record_variable_name)
      raise Error, "\"#{record_variable_name}\" is not allowed as an instance variable name"
    end
  end
end
