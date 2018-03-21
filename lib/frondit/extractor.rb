# frozen_string_literal: true

require 'frondit/validator'

module Frondit
  class Extractor # :nodoc:
    include Validator

    EXCEPT_POLICY_METHODS = %i[user record].freeze

    def initialize(controller_instance, user, policy_class, config)
      @controller_instance  = controller_instance
      @user                 = user
      @policy_class_path    = policy_class
      @rules_to_check       = config[:only]
      @record_variable_name = config[:record].to_sym if config[:record]
    end

    def call
      validate!
      policies
    end

    private

    attr_reader :controller_instance, :user, :policy_class_path, :rules_to_check, :record_variable_name

    def policies
      policies_list.each_with_object({}) do |policy_name, h|
        h[policy_name] = policy.send(policy_name)
      end
    end

    def policies_list
      @_policies_list ||= Array(rules_to_check || policy_rules)
    end

    def policy
      @_policy ||= policy_class.new(user, record)
    end

    def policy_class
      return @policy_class_path if @policy_class_path.is_a? Class
      @_policy_class ||= @policy_class_path.to_s.camelize.safe_constantize
    end

    def policy_rules
      @_policy_rules ||= policy_class.instance_methods(false).reject { |method| method.in? EXCEPT_POLICY_METHODS }
    end

    def record
      return if record_variable_name.blank?
      @_record ||= controller_instance.instance_variable_get(record_variable_name)
    end
  end
end
